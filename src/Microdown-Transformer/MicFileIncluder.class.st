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
	
Note that the path does not exist the transformer does nothing.
"
Class {
	#name : #MicFileIncluder,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'shouldTransform',
		'input',
		'topFile',
		'inProcessFiles'
	],
	#category : #'Microdown-Transformer'
}

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
	
	| inputRef inputDoc|
	"
	* check in input file is absolute or relative
	* if relative, resolve with topFile
	* load referenced microdown
	* recurse with resolved reference as root
	* insert ast into me
	"
	inputRef := anInputFileAnnotation path.
	inputRef isResolved 
		ifFalse: [ 
			inputRef := inputRef resolveWith: topFile.
			anInputFileAnnotation path: inputRef].
	inputDoc := inputRef loadMicrodown.
	inputDoc ifNil: [ ^ self ].
	inputDoc accept: (self class new topFile: inputRef ).
	self replaceCurrentNodeBy: inputDoc children
	
	
	
]

{ #category : #'visiting-document' }
MicFileIncluder >> visitInputFileOld: anInputFileAnnotation [
	"This method is obsolete and must be removed"
	
	| includedFile microdownAST |
	includedFile := anInputFileAnnotation path path.
	self validateInclusionOfFile: includedFile.
	
	includedFile ifExists:[
		"may be better to call back microdown since it defined resolvedTreeFrom:"
		microdownAST := (MicInputDocument forFile: includedFile) parsedDocument.
		MicZinkPathResolver new 	
			originFile: topFile ; visit: microdownAST.
	"Execute a file inclusion step recursively" 
	self class new
		topFile: includedFile;
		inProcessFiles: (inProcessFiles copyWith: topFile);
		visit: microdownAST.
	
	"If we include a file, we need to update all references to external files in it.
	References that were before relative to the included document, should be now relative to the container document."
	MicUpdateFileInclusionReference
		start: microdownAST
		with: (includedFile parent relativeTo: topFile parent) microdownPrintString.
	
	self replaceCurrentNodeBy: microdownAST children]
	
]
