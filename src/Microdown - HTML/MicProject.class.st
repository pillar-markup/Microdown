Class {
	#name : #MicProject,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'templatable'
	],
	#category : #'Microdown - HTML'
}

{ #category : #testing }
MicProject class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
MicProject class >> on: aDirectory [

	^ self new
		baseDirectory: aDirectory;
		yourself
]

{ #category : #accessing }
MicProject class >> pathToString: aPath [
	^ aPath pillarPrintString
]

{ #category : #archetypes }
MicProject >> archetypeNamed: aString [ 
	
	^ MicArchetype new
		name: aString;
		project: self;
		yourself
]

{ #category : #accessing }
MicProject >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
MicProject >> baseDirectory: aFileReference [ 
	baseDirectory := aFileReference
]

{ #category : #templates }
MicProject >> beTemplatable [

	templatable := true
]

{ #category : #building }
MicProject >> build: output [
	"Output is an instance of subclass of PRTarget"
	
	"set up information required prior to pipeline building"
	self prepareForTarget: output.
	
	"Build the pipeline and execute it on each file of the project"
	^ output buildOn: self
]

{ #category : #accessing }
MicProject >> configuration [
	
	| readConfiguration extension |
	extension := Dictionary new.
	extension at: 'outputDirectory' put: self defaultOutputDirectoryName.
	
	"Just for backwards compatibility"
	extension at: '_project' put: self.

	readConfiguration := self configurationFileReference exists
		ifFalse: [ ConfigurationForMicrodown newFromDictionary: extension ]
		ifTrue: [ ConfigurationForMicrodown newFromFile: self configurationFileReference extendedWith: extension ].
	^ readConfiguration
]

{ #category : #accessing }
MicProject >> configurationFileReference [
	
	^ self baseDirectory / 'pillar.conf'
]

{ #category : #building }
MicProject >> contributeToPipelineBuilding: aPRPipelineBuilder [ 
	
	self plugins do: [ :each | each contributeToPipelineBuilding: aPRPipelineBuilder ]
]

{ #category : #accessing }
MicProject >> defaultOutputDirectoryName [
	^ '_result'
]

{ #category : #accessing }
MicProject >> defaultTarget [
	| defaultExport |
	defaultExport := [self configuration defaultExport ifEmpty: [ ^ MicAbsentTarget]] ifError: [ ^ MicAbsentTarget ]  .
	^ MicTarget targetByFormatName: defaultExport
]

{ #category : #initialization }
MicProject >> initialize [

	super initialize.
	templatable := false
]

{ #category : #archetypes }
MicProject >> installArchetypeNamed: archetypeName [
	| archetype |
	archetype := self archetypeNamed: archetypeName.
	archetype validateExists.
	archetype installIn: self baseDirectory
]

{ #category : #archetypes }
MicProject >> installArchetypeNamed: archetypeName fromDirectory: pillarDirectory [
	
	| archetype |
	archetype := self archetypeNamed: archetypeName.
	archetype directory: pillarDirectory.
	archetype validateExists.
	archetype installIn: self baseDirectory
]

{ #category : #templates }
MicProject >> installTemplateNamed: archetypeName [ 
	
	| archetype |
	archetype := self archetypeNamed: archetypeName.
	archetype validateExists.
	archetype installTemplateIn: self baseDirectory
]

{ #category : #templates }
MicProject >> isTemplatable [

	^ templatable
]

{ #category : #accessing }
MicProject >> outputDirectory [
	
	^ self baseDirectory resolve: self configuration outputDirectory
]

{ #category : #accessing }
MicProject >> plugins [
	
	^ (self configuration propertyAt: #plugins ifAbsent: [ #() ])
			collect: [ :each | | plugin |
				plugin := Smalltalk globals
					at: each asSymbol
					ifAbsent: [ self error: 'Could not resolve plugin: ', each ].
				plugin withContext: self ]
]

{ #category : #building }
MicProject >> prepareForTarget: target [
	"We want to build a given project i.e. PDF, HTML. We are setting up the system to be built. With prepareForTarget:, the actions that will be triggered are happening before the pipeline is set and executed."
	
	target prepareForExecutionOn: self.
	self plugins do: [ :each | each prepareForExecutionOn: self ]
]

{ #category : #accessing }
MicProject >> supportDirectory [
	
	^ self baseDirectory / '_support'
]

{ #category : #accessing }
MicProject >> tableOfContents [
	| tocFilePath tocFileName inputDoc |
	tocFilePath := self configuration propertyAt: 'tocFile' ifAbsent: [ ^ MicToc new ].
	tocFileName := self class pathToString: tocFilePath.
	inputDoc := MicroDownParser new parse: (self baseDirectory / tocFileName) contents.
	^ MicTocBuilderVisitor new
		documentSource: self baseDirectory / tocFileName;
		currentFile: tocFileName;
		inProcessFiles: (Array with: self baseDirectory / tocFileName);
		visit: inputDoc
]

{ #category : #'as yet unclassified' }
MicProject >> updateBuild [
	| destination reference |
	reference := FileLocator imageDirectory parent / 'archetypes'.
	destination := FileLocator imageDirectory / 'archetypes'.
	
	destination ensureDeleteAll.

	"Because we copy the archetypes folder from parent into build/archetypes"
	reference copyAllTo: destination
]

{ #category : #actions }
MicProject >> wipeout [
	
	self outputDirectory ensureDeleteAll
]
