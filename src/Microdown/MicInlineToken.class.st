"
I am a token used in inline parsing of Microdown.
I have two instance variables:

- substring, which is the value of the token
- delimiter, which is a reference to a subclass of MicAbstractDelimiter
"
Class {
	#name : 'MicInlineToken',
	#superclass : 'Object',
	#instVars : [
		'delimiter',
		'string'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'accessing' }
MicInlineToken >> delimiter [

	^ delimiter
]

{ #category : 'accessing' }
MicInlineToken >> delimiter: anObject [

	delimiter := anObject
]

{ #category : 'printing' }
MicInlineToken >> printOn: aStream [
	aStream << delimiter printString << $( << string << $)
]

{ #category : 'accessing' }
MicInlineToken >> string [

	^ string
]

{ #category : 'accessing' }
MicInlineToken >> string: anObject [

	string := anObject
]

{ #category : 'accessing' }
MicInlineToken >> undelimitedSubstring [
	"assume I am a token for a unevaluated delimiter, containing raw body - remove my delimiters"
	^string 
		copyFrom: delimiter markup size + 1 
		to: (string size - delimiter closer size)
]
