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
	"We end the link if we find a character that is a whitespace OR a $]. $] should be valid in links but it causes conflicts with the closing bracket of the body of link syntax with the way microdown is coded. Thus, this is a hack to limit the impact of this conflict. We prefer to be able to parse things such as: `[http://mylink.fr](http://mylink.fr)` than matching links containing a $]. "

	^ 'http(s)?\://[^]\s]+'
]
