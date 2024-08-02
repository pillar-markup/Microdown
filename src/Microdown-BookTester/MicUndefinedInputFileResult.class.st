Class {
	#name : 'MicUndefinedInputFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'inputFileBlock'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicUndefinedInputFileResult >> inputFileBlock [

	^ inputFileBlock
]

{ #category : 'inputFileBlock:' }
MicUndefinedInputFileResult >> inputFileBlock: anInputFileBlock [
	inputFileBlock := anInputFileBlock
]
