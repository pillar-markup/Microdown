Class {
	#name : 'MicMethodStructureResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-MethodStructure',
	#package : 'Microdown-Rules',
	#tag : 'MethodStructure'
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
	, '" in file' , fileReference fullName 
	, ' contains a mistake: method ['
	, detail 
	, '] should have an empty line after the selector when is no comment.'
]

{ #category : 'kinds' }
MicMethodStructureResult >> headerString [
    ^ 'Method Structure'
]

{ #category : 'accessing' }
MicMethodStructureResult >> what [
    ^ detail copyReplaceAll: '"' with: ''
]
