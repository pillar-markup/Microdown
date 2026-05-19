Class {
	#name : 'MicMethodReferenceResult',
	#superclass : 'MicResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-BookTester-Checker-MethodReferences',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-MethodReferences'
}

{ #category : 'accessing' }
MicMethodReferenceResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicMethodReferenceResult >> detail: aString [

	detail := aString
]

{ #category : 'accessing' }
MicMethodReferenceResult >> explanation [ 
	^ 'Text: "' , micElement bodyString
	, '" in file' , self inFile fullName 
	, ' contains a mistake: method references must be consistent, either always with # or always without #.'
]
