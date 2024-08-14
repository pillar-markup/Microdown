"
I'm a simple visitor that collects files from a document taking into account inputFile:.

## Todo

### Open question: should we collect also figure files?
Since figures are leaves in the sense that they do not include another list of expressions but just a reference to a file. We could in addition check for the figures and report the unexisting ones. 
I do not think that adding blindly the figures to the visited set is good because the visited (which should be renamed into visitedDocumentFiles ) is about document and not figures.


"
Class {
	#name : 'MicFileCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rootDirectory',
		'visited',
		'unexistingFiles',
		'inputFiles'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicFileCollector >> fileSystem [

	^ fileSystem
]

{ #category : 'accessing' }
MicFileCollector >> fileSystem: aFileSystem [
	
	fileSystem := aFileSystem
]

{ #category : 'visiting' }
MicFileCollector >> initialize [ 

	super initialize.
	rootDirectory := FileSystem workingDirectory.
	visited := Set new.
	unexistingFiles := Set new.
]

{ #category : 'accessing' }
MicFileCollector >> rootDirectory [

	^ rootDirectory
]

{ #category : 'accessing' }
MicFileCollector >> rootDirectory: aFileReference [
	
	rootDirectory := aFileReference
]

{ #category : 'accessing' }
MicFileCollector >> unexistingFiles [

	^ unexistingFiles
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
			fr := self rootDirectory resolve:
				      (inputFile arguments at: 'path') uri asFileReference
					      pathString.
			
			"Since we are just checking that a file exist it does not matter when we check.
			We do not have to wait until we walk through all the files."
			
			(visited includes: fr path pathString) ifFalse: [
				[
				doc := Microdown parseFile: fr.
				worklist addFirst: doc ]
					on: FileDoesNotExistException
					do: [ unexistingFiles add: inputFile ] ] ] ]
]

{ #category : 'accessing' }
MicFileCollector >> visitedDocumentFiles [

	^ visited
]
