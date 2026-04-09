Class {
	#name : 'MicCodeIndentationResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-CodeIndetation',
	#package : 'Microdown-Rules',
	#tag : 'CodeIndetation'
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

{ #category : 'kinds' }
MicCodeIndentationResult >> headerString [
    ^ 'Code Indentation'
]

{ #category : 'accessing' }
MicCodeIndentationResult >> what [
    ^ (detail copyFrom: 2 to: detail size - 1) trim
]
