"
I am a stream of tokens.
I have some logic for assigning delimiter types to the tokens as I build them.
"
Class {
	#name : 'MicInlineTokenStream',
	#superclass : 'Object',
	#instVars : [
		'tokens'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'escape character' }
MicInlineTokenStream class >> backslashDecode: aString [
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

{ #category : 'escape character' }
MicInlineTokenStream class >> backslashEncode: aString [
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

{ #category : 'escape character' }
MicInlineTokenStream class >> backslashReescape: aString except: keep [
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

{ #category : 'escape character' }
MicInlineTokenStream class >> magicCharacter [
	"All escaped characters are moved out of range. 
	The unicode range Private Use Area is used, 
	see https://en.wikipedia.org/wiki/Private_Use_Areas "
	^ 16r100000 "Private Use Area-B"
]

{ #category : 'instance creation' }
MicInlineTokenStream class >> on: escapedStream [
	^ self new tokenize: escapedStream 
]

{ #category : 'adding' }
MicInlineTokenStream >> addDelimiter: string [
	| delimiter decodedString|
	delimiter := (MicInlineDelimiter at: string)
		ifNil: [ (MicInlineDelimiter all reject: #isEvaluated) detect: [ :o | string beginsWith: o markup] ].
	decodedString := delimiter isRawkind 
		ifTrue: [self class backslashReescape: string except: delimiter closer first asString]
		ifFalse: [string].
	tokens add: (MicInlineToken new 
		string: decodedString;
		delimiter: delimiter)
]

{ #category : 'adding' }
MicInlineTokenStream >> addText: matchedString [
	| token |
	token := MicInlineToken new 
		string: (self class backslashDecode: matchedString);
		delimiter: (MicInlineDelimiter at: FixiousTextDelimiter).
	tokens add: token
]

{ #category : 'initialization' }
MicInlineTokenStream >> initialize [
	super initialize.
	tokens := OrderedCollection new
]

{ #category : 'parsing' }
MicInlineTokenStream >> tokenize: rawString [
	| inlineString splits from |
	inlineString := self class backslashEncode: rawString.
	splits := MicInlineDelimiter allRegex matchingRangesIn: inlineString.
	tokens := OrderedCollection new.
	from := 1.
	splits do: [ :delMatch |
		self addText: (inlineString copyFrom: from to: delMatch first - 1).
		self addDelimiter: (inlineString copyFrom: delMatch first to: delMatch last).
		from := delMatch last + 1
		 ].
	from <= inlineString size ifTrue: [ self addText: (inlineString copyFrom: from to: inlineString size) ].
	^ ReadStream on: tokens
	
]
