Class {
	#name : #MicInlineParser2,
	#superclass : #Object,
	#instVars : [
		'delimiterRegEx',
		'delimiterDictionary'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'escape character' }
MicInlineParser2 class >> escapeDecode: aString [
	"I convert all encoded chars back to their original (without the leading escape character)"
	"My sister method escapeEncode encodes into the format I decode from"
	| inStream outStream char special |
	aString ifEmpty: [ ^aString ].
	special := [ :c | c asInteger between: self magicCharacter  and: self magicCharacter + 65536 ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(special value: char)
			ifTrue: [ char := (char asInteger - self magicCharacter ) asCharacter  ].
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'escape character' }
MicInlineParser2 class >> escapeEncode: aString [
	"I convert all escaped characters (eg '\`' or '\\') into special characters which are not used in Microdown"
	"My sister method escapeDecode reverts back"
	| inStream outStream char |
	aString size <= 1 ifTrue: [ ^aString ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(char = $\ and: [ inStream atEnd not ]) 
			ifTrue: [ char := (inStream next asInteger + self magicCharacter) asCharacter  ].
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'escape character' }
MicInlineParser2 class >> escapeReescape: aString except: keep [
	"I convert all encoded back to escaped chars, except the characters in keep"
	"My sister method escapeEncode encodes into the format I decode from"
	| inStream outStream char |
	aString ifEmpty: [ ^aString ].
	inStream := ReadStream on: aString.
	outStream := WriteStream on: String new.
	[ inStream atEnd ] whileFalse: [ 
		char := inStream next.
		(char asInteger between: self magicCharacter  and: self magicCharacter + 65536)
			ifTrue: [ 
				char := (char asInteger - self magicCharacter ) asCharacter.  
				(keep includes: char) ifFalse: [outStream nextPut: $\]] .
		outStream nextPut: char
	].
	^ outStream contents
	
]

{ #category : #'escape character' }
MicInlineParser2 class >> magicCharacter [
	"All escaped characters are moved out of range. 
	The unicode range Private Use Area is used, 
	see https://en.wikipedia.org/wiki/Private_Use_Areas "
	^ 16r100000 "Private Use Area-B"
]

{ #category : #parsing }
MicInlineParser2 >> compactRaws: tokenStream [
	"compact tokenStream so raw/unevaluated is single tokens"
	
	
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> createInlineBlock: token [
	"token is an opening delimiter"
	| closer |
	closer := (delimiterDictionary at: token) associatedInlineBlock closingDelimiter
	
	
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> createInlineBlock: openingDelimiter inStream: aReadStream [ 
	| pos closer bodyStream newBlock|
	pos := aReadStream position.
	closer := openingDelimiter associatedInlineBlock new closingDelimiter.
	(self skipTo: closer inStream: aReadStream)
		ifFalse: [ 
			aReadStream position: pos.
			^ self createTextBlock: openingDelimiter markup].
	bodyStream := ReadStream 
		on: aReadStream contents
		from: pos
		to: aReadStream position - 1.
	newBlock := openingDelimiter associatedInlineBlock new
		substring: (aReadStream contents copyFrom: pos to: aReadStream position -1);
		children: (self eagerParse: bodyStream ).
	^ newBlock 
	
	
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> createTextBlock: token [
	^ MicTextBlock new
		substring: token;
		children: #()
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> eagerParse: tokenStream [
	"return an array of blocks from parsing tokenStream"
	| children child |
	children := OrderedCollection new.
	[ tokenStream atEnd ]
		whileFalse: [ | token delType |
			token := tokenStream next.
			delType := delimiterDictionary at: token ifAbsent: [ nil ].
			child := (delType
				ifNil: [ self createTextBlock: token ]
				ifNotNil: [ 
					delType isOpener 
						ifTrue: [self createInlineBlock: delType inStream: tokenStream]
						ifFalse: [ self createTextBlock: token] ]).
			children add: child.
		].
	^ children
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> initialize [
	delimiterRegEx := MicAbstractDelimiter allRegex.
	delimiterDictionary := (MicAbstractDelimiter allActive collect: [ :del | del markup -> del ]) asDictionary .
]

{ #category : #parsing }
MicInlineParser2 >> parse: aString [
	"I return an array of inline blocks"
	| escapedStream  tokenStream |
	escapedStream := self class escapeEncode: aString.
	tokenStream := self tokenize: escapedStream.
	^ self eagerParse: tokenStream 
]

{ #category : #'as yet unclassified' }
MicInlineParser2 >> skipTo: closer inStream: tokenStream [
	"skip tokenStream to closer, ignore closers in non-evaluated. return true if we found it"
	| startPos|
	startPos := tokenStream position.
	[ tokenStream atEnd]
		whileFalse: [ | token|
			token := tokenStream next.
			token = closer ifTrue: [ ^true ]
			 ].
	^ false
	
]

{ #category : #parsing }
MicInlineParser2 >> tokenize: escapedStream [
	| splits tokens from|
	splits := delimiterRegEx matchingRangesIn: escapedStream.
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
