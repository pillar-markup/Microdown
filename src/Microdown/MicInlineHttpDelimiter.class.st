"
I implement the inline use of `https://somewhere.com` as a link directly in microdown.
I am recognized by `http[s]://(something not whitespace)+`.
I have an unfortunate restiction, if I am inlined in an other inline block, I should be followed by a whitespace.
Forexample `**https://somewhere.org_**` (`_` representing Character space)
"
Class {
	#name : #MicInlineHttpDelimiter,
	#superclass : #MicInlineDelimiter,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #initialization }
MicInlineHttpDelimiter class >> initializeDelimiters [
	self new addMe.
	
]

{ #category : #accessing }
MicInlineHttpDelimiter >> blockClass [
	^ MicInlineHttpBlock
]

{ #category : #accessing }
MicInlineHttpDelimiter >> closer [
	^ String space
]

{ #category : #testing }
MicInlineHttpDelimiter >> isRawkind [
	"I am an opener whose resulting nodes body is not further parsed"
	^ true
]

{ #category : #accessing }
MicInlineHttpDelimiter >> markup [
	^ 'http'
]

{ #category : #accessing }
MicInlineHttpDelimiter >> markupAsRegex [
	^ 'http(s)?\://[\S]+' 
]
