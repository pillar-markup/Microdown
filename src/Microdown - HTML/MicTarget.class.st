Class {
	#name : #MicTarget,
	#superclass : #Object,
	#instVars : [
		'buildStrategy',
		'transformations'
	],
	#category : #'Microdown - HTML'
}

{ #category : #clap }
MicTarget class >> buildClapCommand [
	
	^ self buildClapCommandWithId: self clapId withPositionals: true
]

{ #category : #clap }
MicTarget class >> buildClapCommandWithId: anId withPositionals: isWithPositionals [
	
	| target project command |
	target := self new.
	project := self newProject.
 
	command := (ClapCommand id: anId asSymbol)
		description: 'Build your Pillar documents in ', self clapId asString ,' format';
		add: ClapFlag forHelp;
		add: ((ClapFlag id: #templatable)
				description: 'Use a template');
				meaning: [project beTemplatable];
		add: ((ClapFlag id: #all)
				description: 'Build all Pillar documents in repository';
				canonicalName: 'a';
				meaning: [ MicBuildAllStrategy new ]);
		add: ((ClapFlag id: #mainRoot)
				description: 'Build index.pillar in root directory';
				canonicalName: 'm';
				meaning: [ MicBuildRootMainStrategy new ]); yourself.
				
		isWithPositionals ifTrue: [ command := command add: ((ClapPositional id: #requestedFiles)
				description: 'Pillar files you want to build';
				multiple: true;
				meaning: [ :doc | doc word asFileReference ]); yourself ].
		
		command := command meaning: [ :args |
			args at: #helpFlag ifPresent: [ :help | help value; exitSuccess ].
			args at: #templatable ifPresent: [(args at: #templatable) value ].
			"here, default strategy is mainRoot and the following order give strategies a priority order"
			isWithPositionals ifTrue: [ 
			(args at: #requestedFiles ) isExplicit ifTrue:[ 
				target buildStrategy: (MicBuildListStrategy list: (args occurrencesOf: #requestedFiles collect: #value) )
				] ].
			args at: #all ifPresent: [ :strat | target buildStrategy: strat value ].
			args at: #mainRoot ifPresent: [ :strat | target buildStrategy: strat value].
			
			target buildWithClapArguments: project ]
		
		yourself.
		
		^ command.
]

{ #category : #accessing }
MicTarget class >> builderClassForName: aString [ 
	
	| builders |
	builders := self allSubclasses select: [ :each | 
		each isAbstract not and: [ each builderName = aString ] ].
	builders size > 1 ifTrue: [ 
		self error: 'There is more than one builder class for name: ', aString ].
	^ builders anyOne
]

{ #category : #accessing }
MicTarget class >> builderForName: aString [ 
	
	^ (self builderClassForName: aString) new
]

{ #category : #accessing }
MicTarget class >> builderName [
	
	^ self subclassResponsibility
]

{ #category : #clap }
MicTarget class >> clapCommandList [
	^ self allSubclasses
		select: [ :each | each isAbstract not ]
		thenCollect: [ :each | each buildClapCommand ]
]

{ #category : #clap }
MicTarget class >> clapId [
	
	^ self builderName 
]

{ #category : #testing }
MicTarget class >> isAbstract [
	^ self == MicTarget
]

{ #category : #'clap-integration' }
MicTarget class >> newProject [

	^ MicProject on: FileSystem workingDirectory
]

{ #category : #accessing }
MicTarget class >> targetByFormatName: aFormat [
	^ self allSubclasses
		detect: [ :each | (each isAbstract not) and: [each builderName asString = aFormat asString] ] ifNone: [ ^ MicInvalidTarget ]
]

{ #category : #accessing }
MicTarget >> addPillarDocumentTransformation: aTransformation [
	
	transformations add: aTransformation
]

{ #category : #building }
MicTarget >> allFilesStrategy [

	self buildStrategy: MicBuildAllStrategy new
]

{ #category : #building }
MicTarget >> buildOn: aProject [
	"Set the pipeline and execute it for each file of the project."
	| status |
	status := MicSuccess new.
	
	"Set the pipeline"
	aProject contributeToPipelineBuilding: self.
	
	"For each file, we execute the pipeline"
	(self filesToBuildOn: aProject) do: [ :each |
		status := status and: ((self documentFor: each) buildOn: aProject) ].

	^ status
]

{ #category : #accessing }
MicTarget >> buildStrategy: aStrategy [
	buildStrategy := aStrategy
]

{ #category : #'clap-integration' }
MicTarget >> buildWithClapArguments: project [

	(project build: self) exitProcess
]

{ #category : #building }
MicTarget >> documentFor: aFile [

	self subclassResponsibility
]

{ #category : #building }
MicTarget >> explicitFilesStrategyOn: aListOfFileReferences [

	self buildStrategy: (MicBuildListStrategy list: aListOfFileReferences)
]

{ #category : #building }
MicTarget >> filesToBuildOn: aPRProject [ 
	
	^ buildStrategy filesToBuildOn: aPRProject
]

{ #category : #initialization }
MicTarget >> initialize [
	super initialize.
	transformations := Set new.
	"self buildAll"
	buildStrategy := MicBuildRootMainStrategy new.
]

{ #category : #building }
MicTarget >> onlyMainRootStrategy [

	self buildStrategy: MicBuildRootMainStrategy new
]

{ #category : #preparation }
MicTarget >> prepareForExecutionOn: aPRProject [ 
	
	self subclassResponsibility
]

{ #category : #accessing }
MicTarget >> transformations [
	
	^ transformations
]
