"
I am a token used in inline parsing of Microdown.
I have two instance variables:

- substring, which is the value of the token
- delimiter, which is a reference to a subclass of MicAbstractDelimiter
"
Class {
	#name : #MicInlineToken,
	#superclass : #Object,
	#instVars : [
		'substring',
		'delimiter'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicInlineToken >> delimiter [

	^ delimiter
]

{ #category : #accessing }
MicInlineToken >> delimiter: anObject [

	delimiter := anObject
]

{ #category : #accessing }
MicInlineToken >> substring [

	^ substring
]

{ #category : #accessing }
MicInlineToken >> substring: anObject [

	substring := anObject
]
