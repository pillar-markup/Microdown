"
I am a stream of tokens.
I have some logic for assigning delimiter types to the tokens as I build them.
"
Class {
	#name : #MicInlineTokenStream,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'parser'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #'as yet unclassified' }
MicInlineTokenStream class >> allRegex [
	^ ((MicInlineDelimiter all collect: #markupAsRegex) joinUsing: '|') asRegex
	
]

{ #category : #'instance creation' }
MicInlineTokenStream class >> on: escapedStream [
	^ self new tokenize: escapedStream 
]

{ #category : #initialization }
MicInlineTokenStream >> add: string [
	"Transform into token, and add it"
	| delimiter token |
	delimiter := MicInlineDelimiter at: string.
	delimiter
		ifNil: [ self addRawOrText: string ]
		ifNotNil: [ self addDelimiter: delimiter ]
]

{ #category : #adding }
MicInlineTokenStream >> addDelimiter: matchedString [
	tokens add: (MicInlineToken new 
		substring: matchedString;
		delimiter: (MicInlineDelimiter at: matchedString ))
]

{ #category : #adding }
MicInlineTokenStream >> addRawOrText: matchedString [
	| opener token |
	opener := (MicInlineDelimiter all reject: #isEvaluated)
		detect: [ :o | matchedString beginsWith: o markup]
		ifNone: [ nil ].
	token := MicInlineToken new 
		substring: matchedString;
		delimiter: opener.
	tokens add: token
]

{ #category : #initialization }
MicInlineTokenStream >> initialize [
	tokens := OrderedCollection new
]

{ #category : #parsing }
MicInlineTokenStream >> tokenize: escapedStream [
	| splits from|
	splits := self class allRegex matchingRangesIn: escapedStream.
	tokens := OrderedCollection new.
	from := 1.
	splits do: [ :delMatch |
		self add: (escapedStream copyFrom: from to: delMatch first - 1).
		self add: (escapedStream copyFrom: delMatch first to: delMatch last).
		from := delMatch last + 1
		 ].
	from <= escapedStream size ifTrue: [ self add: (escapedStream copyFrom: from to: escapedStream size) ].
	^ ReadStream on: tokens
	
]
