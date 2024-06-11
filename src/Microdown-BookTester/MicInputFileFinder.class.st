Class {
	#name : 'MicInputFileFinder',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allFiles'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicInputFileFinder >> allFiles [
	^ allFiles
]

{ #category : 'initialization' }
MicInputFileFinder >> initialize [

	super initialize. 
	allFiles := OrderedCollection new.
]

{ #category : 'initialization' }
MicInputFileFinder >> visitInputFile: anInputFile [

	allFiles add: anInputFile
]
