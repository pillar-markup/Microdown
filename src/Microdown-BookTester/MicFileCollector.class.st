"
I'm a simple visitor that collects files from a document taking into account inputFile:.

## Todo

- We should collect also figures files!
"
Class {
	#name : 'MicFileCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'fileSystem',
		'visited',
		'unexistingFiles',
		'inputFiles'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicFileCollector >> fileSystem [

	^ fileSystem ifNil: [ FileSystem disk ]
]

{ #category : 'accessing' }
MicFileCollector >> fileSystem: aFileSystem [
	
	fileSystem := aFileSystem
]

{ #category : 'visiting' }
MicFileCollector >> initialize [ 

	super initialize.
	visited := Set new.
	unexistingFiles := Set new.
]

{ #category : 'visiting' }
MicFileCollector >> visitInputFile: anInputFile [

	inputFiles add: anInputFile
]

{ #category : 'visiting' }
MicFileCollector >> visitRoot: micDocument [

	| worklist |
	worklist := OrderedCollection new.
	worklist add: micDocument.
	
	[ worklist isEmpty ] whileFalse: [
		| currentDocument |
		currentDocument := worklist removeFirst.
		visited add: currentDocument fromFile.
		currentDocument resolveYourself.

		inputFiles := OrderedCollection new.
		"treat all the inputFile from the current document"
		self visitChildrenOf: currentDocument.

		inputFiles do: [ :inputFile |
			| fr doc |
			"later we will have to fix this ugly expression"
			fr := self fileSystem referenceTo:
				      (inputFile arguments at: 'path') uri asFileReference pathString.

			(visited includes: fr path pathString) ifFalse: [
				[ doc := Microdown parseFile: fr.
				worklist addFirst: doc ]
					on: FileDoesNotExistException
					do: [ unexistingFiles add: inputFile ].
				] 
			] 
		]
]

{ #category : 'accessing' }
MicFileCollector >> visited [

	^ visited
]
