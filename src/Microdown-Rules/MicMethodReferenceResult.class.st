Class {
	#name : 'MicMethodReferenceResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-MethodeReference',
	#package : 'Microdown-Rules',
	#tag : 'MethodeReference'
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
	, '" in file' , fileReference fullName 
	, ' contains a mistake: method references must be consistent, either always with # or always without #.'
]

{ #category : 'kinds' }
MicMethodReferenceResult >> headerString [
    ^ 'Method Reference'
]
