Class {
	#name : 'MicUndefinedInputFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'inputFileBlock'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'kinds' }
MicUndefinedInputFileResult class >> headerString [

	^ 'Undefined input files:'
]

{ #category : 'inputFileBlock:' }
MicUndefinedInputFileResult >> inputFile [ 
	
	^ inputFileBlock path
]

{ #category : 'accessing' }
MicUndefinedInputFileResult >> inputFileBlock [

	^ inputFileBlock
]

{ #category : 'inputFileBlock:' }
MicUndefinedInputFileResult >> inputFileBlock: anInputFileBlock [
	inputFileBlock := anInputFileBlock
]

{ #category : 'accessing' }
MicUndefinedInputFileResult >> what [ 

	^ self inputFile
]
