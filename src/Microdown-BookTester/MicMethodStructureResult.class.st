Class {
	#name : 'MicMethodStructureResult',
	#superclass : 'MicResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-BookTester-Checker-MethodStructure',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-MethodStructure'
}

{ #category : 'accessing' }
MicMethodStructureResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicMethodStructureResult >> detail: aString [

	detail := aString
]

{ #category : 'accessing' }
MicMethodStructureResult >> explanation [ 
	^ 'Text: "' , micElement body 
	, '" in file' , self inFile fromFile fullName 
	, ' contains a mistake: method ['
	, detail 
	, '] should have an empty line after the selector when is no comment.'
]

{ #category : 'kinds' }
MicMethodStructureResult >> headerString [

	^ 'Method Structure'
]
