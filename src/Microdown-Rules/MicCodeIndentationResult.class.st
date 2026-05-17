Class {
	#name : 'MicCodeIndentationResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-CodeIndentation',
	#package : 'Microdown-Rules',
	#tag : 'CodeIndentation'
}

{ #category : 'accessing' }
MicCodeIndentationResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicCodeIndentationResult >> detail: anObject [

	detail := anObject
]

{ #category : 'accessing' }
MicCodeIndentationResult >> explanation [ 
	^ 'Text: "' , micElement body
	, '" in file' , fileReference fullName
	, ' contains a mistake: line ['
	, detail 
	, '] should use tabs instead of spaces for indentation.'
]
