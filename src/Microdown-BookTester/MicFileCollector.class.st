"
I'm a simple visitor that collects files from a document taking into account inputFile:.

## Todo

- We should collect also figures files!
"
Class {
	#name : 'MicFileCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'inputs',
		'fileSystem',
		'visited',
		'unexistingFiles'
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
MicFileCollector >> visitInputFile: anInputFile [

	inputs add: anInputFile
]

{ #category : 'visiting' }
MicFileCollector >> visitRoot: micDocument [

	| worklist |
	unexistingFiles := Set new.
	worklist := OrderedCollection new.
	worklist add: micDocument.
	visited := Set new.

	[ worklist isEmpty ] whileFalse: [
		| currentDocument |
		currentDocument := worklist removeFirst.
		visited add: currentDocument fromFile.

		MicZincPathResolver
			resolve: currentDocument
			withBase: currentDocument fromFile.

		inputs := OrderedCollection new.
		self visitChildrenOf: currentDocument.

		inputs do: [ :inputFile |
			| fr doc |
			fr := self fileSystem referenceTo:
				      (inputFile arguments at: 'path') uri asFileReference
					      pathString.

			(visited includes: fr path pathString) ifFalse: [
				[ doc := Microdown parseFile: fr ]
					on: FileDoesNotExistException
					do: [ unexistingFiles add: inputFile ].
				doc ifNotNil: [ worklist addFirst: doc ]] ] ]
]

{ #category : 'accessing' }
MicFileCollector >> visited [

	^ visited
]
