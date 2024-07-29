"
I'm a simple visitor that collects file input nodes from a document. 
"
Class {
	#name : 'MicFilesCollector',
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
MicFilesCollector >> fileSystem [

	^ fileSystem ifNil: [ FileSystem disk ]
]

{ #category : 'accessing' }
MicFilesCollector >> fileSystem: aFileSystem [
	"Can specify a file system for tests"
	fileSystem := aFileSystem
]

{ #category : 'visiting' }
MicFilesCollector >> visitInputFile: anInputFile [

	inputs add: anInputFile
]

{ #category : 'visiting' }
MicFilesCollector >> visitRoot: micDocument [

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
				doc ifNotNil: [worklist addFirst: doc]] ] ]
]

{ #category : 'accessing' }
MicFilesCollector >> visited [

	^ visited
]

{ #category : 'accessing' }
MicFilesCollector >> visited: anObject [

	visited := anObject
]
