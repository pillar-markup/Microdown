"
MicFileInclusion replace the MicInputfileBlock by the nodes obtain during the parse of file.

For a file name example.mic which contains :

# Foo

this is a paragraph

```
 this is a code
```

the transformer transform `?{fileinput?path=example.mic}?` by : 

# Foo

this is a paragraph

```
 this is a code
```

And if the path does not exist the transformer do nothing
"
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
	#category : #'Microdown-Transformer'
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
MicFileInclusion >> visitInputfile: anInputFileAnnotation [
	"I load the file and if the file exist I replace the node of the annotation by the content of the file."
	| includedFile microdownAST |
	includedFile := topFile parent resolve: anInputFileAnnotation path.
	self validateInclusionOfFile: includedFile.
	 includedFile ifExists:[
		microdownAST := (MicInputDocument forFile: includedFile) parsedDocument.
	
	MicCleanAnnotationInParagraph new visit: microdownAST.
	
	"Execute a file inclusion step recursively" 
	microdownAST := MicFileInclusion new
		topFile: includedFile;
		inProcessFiles: (inProcessFiles copyWith: topFile);
		start: microdownAST.
	
	"If we include a file, we need to update all references to external files in it.
	References that were before relative to the included document, should be now relative to the container document."
	MicUpdateFileInclusionReference
		start: microdownAST
		with: (includedFile parent relativeTo: topFile parent) pillarPrintString.
	
	self replace: microdownAST children]
	
]
