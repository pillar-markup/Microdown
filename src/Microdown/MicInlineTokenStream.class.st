"
I am a stream of tokens.
I have some logic for assigning delimiter types to the tokens as I build them.
"
Class {
	#name : #MicInlineTokenStream,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'parser',
		'delimiterDictionary'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #'instance creation' }
MicInlineTokenStream class >> on: escapedStream [
	^ self new tokenize: escapedStream 
]

{ #category : #initialization }
MicInlineTokenStream >> add: string [
	"Transform into token, and add it"
	| delimiter child |
	delimiter := delimiterDictionary at: string ifAbsent: [ nil ].
	child := delimiter
		ifNil: [ self addRawOrText: delimiter ]
		ifNotNil: [ self addDelimiter: delimiter ]
]

{ #category : #adding }
MicInlineTokenStream >> addRawOrText: delimiter [
	| opener token |
	opener := (MicAbstractDelimiter rawStyleOpeningMarkups)
		detect: [ :o | delimiter beginsWith: o markup]
		ifNone: [ nil ].
	token := MicInlineToken new 
		substring: delimiter;
		delimiter: opener.
]

{ #category : #initialization }
MicInlineTokenStream >> initialize [
	tokens := OrderedCollection new
]

{ #category : #parsing }
MicInlineTokenStream >> tokenize: escapedStream [
	| splits from|
	splits := self delimiterRegEx matchingRangesIn: escapedStream.
	tokens := OrderedCollection new.
	from := 1.
	splits do: [ :delMatch |
		tokens add: (escapedStream copyFrom: from to: delMatch first - 1).
		tokens add: (escapedStream copyFrom: delMatch first to: delMatch last).
		from := delMatch last + 1
		 ].
	from <= escapedStream size ifTrue: [ tokens add: (escapedStream copyFrom: from to: escapedStream size) ].
	^ ReadStream on: tokens
	
]
