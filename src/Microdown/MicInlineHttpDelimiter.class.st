"
I implement the inline use of `https://somewhere.com` as a link directly in Microdown.
I am recognized by `http[s]://(something not whitespace)+`.
I have an unfortunate restriction, if I am inlined in another inline block, I should be followed by a whitespace.
For example `**https://somewhere.org_**` (with `_` representing Character space).
"
Class {
	#name : 'MicInlineHttpDelimiter',
	#superclass : 'MicInlineDelimiter',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'initialization' }
MicInlineHttpDelimiter class >> initializeDelimiters [
	self new addMe.
	
]

{ #category : 'accessing' }
MicInlineHttpDelimiter >> blockClass [
	^ MicInlineHttpBlock
]

{ #category : 'accessing' }
MicInlineHttpDelimiter >> closer [
	^ String space
]

{ #category : 'testing' }
MicInlineHttpDelimiter >> isRawkind [
	"I am an opener whose resulting nodes body is not further parsed"
	^ true
]

{ #category : 'accessing' }
MicInlineHttpDelimiter >> markup [
	^ 'http'
]

{ #category : 'accessing' }
MicInlineHttpDelimiter >> markupAsRegex [
	^ 'http(s)?\://[\S]+' 
]
