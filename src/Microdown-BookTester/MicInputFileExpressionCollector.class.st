"
I'm a simple visitor that collects file input nodes from a document. 
"
Class {
	#name : 'MicInputFileExpressionCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allFiles',
		'baseDirectory',
		'currentDirectory',
		'previousDirecotry',
		'dirs'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicInputFileExpressionCollector >> allFiles [
	^ allFiles
]

{ #category : 'accessing' }
MicInputFileExpressionCollector >> baseDirectory [

	^ baseDirectory
]

{ #category : 'accessing' }
MicInputFileExpressionCollector >> baseDirectory: anObject [

	baseDirectory := anObject.
	currentDirectory := baseDirectory 
]

{ #category : 'initialization' }
MicInputFileExpressionCollector >> initialize [

	super initialize. 
	allFiles := Set new.
	dirs := OrderedCollection new
]

{ #category : 'initialization' }
MicInputFileExpressionCollector >> visitInputFile: anInputFile [

	
	| fileReference |
	MicZincPathResolver
		resolve: anInputFile  
		withBase: currentDirectory asMicResourceReference.
	
	fileReference := currentDirectory fileSystem referenceTo:
			 (anInputFile arguments at: 'path') uri asFileReference pathString.
			self halt .
	(allFiles includes: fileReference) ifTrue: [ ^ self ].
	allFiles add: fileReference.
	dirs addLast: currentDirectory.
	currentDirectory := fileReference.
	self halt .
	self visit: (Microdown parseFile: fileReference).
	currentDirectory := dirs removeLast
]
