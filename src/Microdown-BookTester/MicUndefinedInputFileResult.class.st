"
I represent an input referencing a file that does not exist.
"
Class {
	#name : 'MicUndefinedInputFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'inputFileBlock'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicUndefinedInputFileResult class >> errorType [

	^ 'UndefinedInputFiles'
]

{ #category : 'kinds' }
MicUndefinedInputFileResult class >> headerString [

	^ 'Undefined input files:'
]

{ #category : 'accessing' }
MicUndefinedInputFileResult >> explanation [

	^ 'Undefined file input: ', self what,' (in file ', source fullName , ') refer to file that does not exist.'
	
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

	| path |
	self flag: #fixItLatter.
	path := self inputFileBlock path.
	^ path isString 
		ifTrue: [ path ]
		ifFalse: [ path fullName ]
]
