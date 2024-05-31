"
I add two github variations of bold and italic.
In Microdown bold is with `**` and italic with `_`.
I add bold also with `__`, and italic with `*`.


"
Class {
	#name : 'MicInlineAlternativesDelimiter',
	#superclass : 'MicInlineStandardDelimiter',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'initialization' }
MicInlineAlternativesDelimiter class >> initializeDelimiters [
	
	"formating"
	self new markup: '__'; blockClass: MicBoldFormatBlock; closer: '__'; addMe.
	self new markup: '*'; blockClass: MicItalicFormatBlock; closer: '*'; addMe.
	
]
