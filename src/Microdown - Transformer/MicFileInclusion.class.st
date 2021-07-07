Class {
	#name : #MicFileInclusion,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'shouldTransform',
		'input',
		'goal',
		'topFile',
		'expansionTask',
		'inProcessFiles'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #configuration }
MicFileInclusion >> doNotTransform [
	shouldTransform := false
]

{ #category : #accessing }
MicFileInclusion >> expansionTask: aMicExpandInclusionsTask [ 
	expansionTask := aMicExpandInclusionsTask
]

{ #category : #accessing }
MicFileInclusion >> goal: aGoal [ 
	goal := aGoal
]

{ #category : #accessing }
MicFileInclusion >> inProcessFiles: aCollection [ 
	inProcessFiles := aCollection
]

{ #category : #initialization }
MicFileInclusion >> initialize [

	super initialize.
	inProcessFiles := #()
]

{ #category : #'visiting-document' }
MicFileInclusion >> input: anInputDocument [

	input := anInputDocument
]

{ #category : #testing }
MicFileInclusion >> isFileInclusionPhase [
	
	^ true
]

{ #category : #testing }
MicFileInclusion >> shouldTransform [
	^ shouldTransform ifNil: [ shouldTransform := true ]
]

{ #category : #accessing }
MicFileInclusion >> topFile: aFileReference [

	topFile := aFileReference
]

{ #category : #validation }
MicFileInclusion >> validateInclusionOfFile: aFileReference [ 
	
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
MicFileInclusion >> visitInputFileAnnotation: anInputFileAnnotation [
	"I load the file and if the file exist I replace the node of the annotation by the content of the file."
	| includedFile includedMicrodownAST cleanMicrodownAST |
	includedFile := topFile parent resolve: anInputFileAnnotation path.
	self validateInclusionOfFile: includedFile.
	
	includedMicrodownAST := (MicInputDocument forFile: includedFile) parsedDocument.
	
	cleanMicrodownAST := (MicCleanAnnotationInParagraphTransformer new
		"configuration: self configuration;"
		start: includedMicrodownAST).
	
	"Execute a file inclusion step recursively" 
	includedMicrodownAST := MicFileInclusion new
		topFile: includedFile;
		inProcessFiles: (inProcessFiles copyWith: topFile);
		start: cleanMicrodownAST.
	
	"If we include a file, we need to update all references to external files in it.
	References that were before relative to the included document, should be now relative to the container document."
	MicUpdateFileInclusionReference
		start: includedMicrodownAST
		with: (includedFile parent relativeTo: topFile parent) pillarPrintString.
	
	self replace: includedMicrodownAST children.
]
