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
	#name : #MicFileIncluder,
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
MicFileIncluder >> visitInputfile: anInputFileAnnotation [
	"I load the file and if the file exist I replace the node of the annotation by the content of the file."
	
	| includedFile microdownAST |
	includedFile := topFile / anInputFileAnnotation path.
	self validateInclusionOfFile: includedFile.
	includedFile ifExists:[
		microdownAST := (MicInputDocument forFile: includedFile) parsedDocument.
	
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
