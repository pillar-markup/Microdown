"
I'm a simple visitor that collects file input nodes from a document. 
"
Class {
	#name : 'MicInputFileExpressionCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allFiles'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicInputFileExpressionCollector >> allFiles [
	^ allFiles
]

{ #category : 'initialization' }
MicInputFileExpressionCollector >> initialize [

	super initialize. 
	allFiles := OrderedCollection new.
]

{ #category : 'initialization' }
MicInputFileExpressionCollector >> visitInputFile: anInputFile [

	allFiles add: anInputFile
]
