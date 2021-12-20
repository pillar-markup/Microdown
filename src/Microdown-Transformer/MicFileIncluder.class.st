"
I replace the inputFileBlock by the nodes of the file.
In particular I resolve paths to the correct places.
For example imagine that we have the file 

`Books/Book1/index.mic`
containing 
	`${inputfile&path=SUnit/SUnit.mic$`
	
and that `SUnit/SUnit.mic` contains a figure
such as 
	`![](figures/setUpTearDown.png)`
	
Such `figures/setUpTearDown.png` file should get its path being: `Books/Book1/SUnit/figures/setUpTearDown.png`
	
Note that if the path does not exist the transformer does nothing.
"
Class {
	#name : #MicFileIncluder,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'shouldTransform',
		'input',
		'topFile',
		'inProcessFiles',
		'isStrict'
	],
	#category : #'Microdown-Transformer'
}

{ #category : #initialization }
MicFileIncluder >> beRelaxed [

	isStrict := false
]

{ #category : #configuration }
MicFileIncluder >> doNotTransform [
	shouldTransform := false
]

{ #category : #accessing }
MicFileIncluder >> inProcessFiles: aCollection [ 
	inProcessFiles := aCollection
]

{ #category : #initialization }
MicFileIncluder >> initialize [

	super initialize.
	isStrict := true.
	inProcessFiles := #()
]

{ #category : #'visiting-document' }
MicFileIncluder >> input: anInputDocument [

	input := anInputDocument
]

{ #category : #testing }
MicFileIncluder >> shouldTransform [
	^ shouldTransform ifNil: [ shouldTransform := true ]
]

{ #category : #accessing }
MicFileIncluder >> topFile: aFileReference [

	topFile := aFileReference
]

{ #category : #validation }
MicFileIncluder >> validateInclusionOfFile: aFileReference [ 
	
	aFileReference = topFile ifTrue: [ 
		MicCyclicFileInclusionError new
			files: { topFile };
			signal
	].

	(inProcessFiles includes: aFileReference)
		ifTrue: [ MicCyclicFileInclusionError new
			files: (inProcessFiles copyWith: aFileReference);
			signal  ]
]

{ #category : #'visiting-document' }
MicFileIncluder >> visitInputFile: anInputFileAnnotation [
	"I load the file and if the file exist I replace the node of the annotation by the content of the file."
	
	| inputRef inputDoc fileReference resource |
	"
	check in input file is absolute or relative
	if relative, resolve with topFile
	load referenced microdown
	recurse with resolved reference as root
	insert ast into me
	"
	inputRef := anInputFileAnnotation path.
	resource := inputRef resolveResourceIn: (MicUrlResolver new
		currentWorkingDirectory: topFile;
		yourself).
	
	"If we are in relaxed mode and the file does not exist, do not try including it"
	(isStrict not and: [ resource exists not])
		ifTrue: [ ^ self ].
	
	inputDoc := resource parseMicrodown.
	inputDoc accept: (self class new topFile: inputRef).
	self replaceCurrentNodeBy: inputDoc children
	
]
