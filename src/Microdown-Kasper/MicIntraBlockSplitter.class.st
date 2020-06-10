"
I am an intra-line parser as part of the original implementation of K. Osterbye. I handle emphasis (bold, italics, strikethrough), inlined code, links and images.

My main method is the #splitBlock:. 

No other method is part of the api.

"
Class {
	#name : #MicIntraBlockSplitter,
	#superclass : #Object,
	#category : #'Microdown-Kasper'
}

{ #category : #'private-matching' }
MicIntraBlockSplitter >> match: size in: aString at: start [
	"return the end of the string enclosed in the marker from start to start+size.
	If no end marker is found, return the end of string.
	Normal example: match: 2 in: 'abc**mmm**xyz' at: 4 returns 9 (index of first * of the last two)"
	| end |
	end := aString
		findString: (aString copyFrom: start to: start + size - 1)
		startingAt: start + size.
	^ end = 0 ifTrue: [ aString size ] ifFalse: [ end-1 ]
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchBlockIn: aString at: start [
	| end |
	end := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: end
		next: end+2
		kind: #block
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchBoldIn: aString at: start [
	| end |
	end := self match: 2 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 2
		to: end 
		next: end +3
		kind: #bold
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchImageIn: aString at: start [
	"image annotation ![AltText](url)"

	| regex text url next |
	regex := RxMatcher forString: '!\[([^]]*)\]\(([^)]*)\)'.
	regex matches: (aString copyFrom: start to: aString size).
	regex lastResult ifFalse: [ ^nil ].
	text := regex subexpression: 2.
	url := regex subexpression: 3.
	next := start + (regex subexpression: 1) size.
	^ MicInlineBlockWithUrl new
		string: aString;
		start: start + 2;
		end: start + 2 + text size - 1;
		url: url;
		next: next;
		kind: #image
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchItalicsIn: aString at: start [
	| next |
	next := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: next 
		next: next +2
		kind: #italics
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchLinkIn: aString at: start [
	"link annotation [AltText](url)"

	| index count c text url next regex |
	count := 1.
	index := start.
	"Move past inner [] (typically from an image)"
	[ (count > 0) & (index <= aString size) ] whileTrue: [ 
		index := index +1.
		c := aString at: index.
		c = $[ ifTrue: [count := count +1].
		c = $] ifTrue: [count := count -1]].
	index > aString size ifTrue: [ ^nil ].
	text := aString copyFrom: start +1 to: index -1 .
	"now look to see if there is a url "
	regex := RxMatcher forString: '(\(([^)]*)\))?'.
	regex matches: (aString copyFrom: index +1 to: aString size).
	url := regex lastResult 
		ifTrue:[regex subexpression: 3]
		ifFalse: [ text ].
	next := index+1 + (regex subexpression: 2) size.
	^ MicInlineBlockWithUrl new
		string: aString;
		start: start + 1;
		end: start + 1 + text size - 1;
		url: url;
		next: next;
		kind: #link
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchMarkdownIn: aString at: start [
	| char |
	start >= aString size
		ifTrue: [ ^ nil ].
	char := aString at: start.
	char = $* | (char = $_)
		ifTrue: [ (aString at: start + 1) = $*
				ifTrue: [ ^ self matchBoldIn: aString at: start ]
				ifFalse: [ ^ self matchItalicsIn: aString at: start ] ].
	char = $~
		ifTrue: [ ^ self matchStrikeOutIn: aString at: start ].
	char = $`
		ifTrue: [ ^ self matchBlockIn: aString at: start ].
	char = $!
		ifTrue: [ ^ self matchImageIn: aString at: start ].
	char = $[
		ifTrue: [ ^self matchLinkIn: aString at: start  ].
	^ nil
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> matchStrikeOutIn: aString at: start [
	| next |
	next := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: next
		next: next +2
		kind: #strike
]

{ #category : #'private-matching' }
MicIntraBlockSplitter >> old_matchLinkIn: aString at: start [
	"link annotation [AltText](url)"

	| regex text url next |
	regex := RxMatcher forString: '\[([^[]]*|(.*\[(.*)\]).*)\](\(([^)]*)\))?'.
	regex matches: (aString copyFrom: start to: aString size).
	regex lastResult
		ifFalse: [ ^ nil ].
	text := regex subexpression: 2.
	url := (regex subexpression: 4) ifNotNil: [ :u | u ] ifNil: [ text ].
	next := start + (regex subexpression: 1) size.
	^ MicInlineBlockWithUrl new
		string: aString;
		start: start + 1;
		end: start + 1 + text size - 1;
		url: url;
		next: next;
		kind: #link
]

{ #category : #'as yet unclassified' }
MicIntraBlockSplitter >> pillarFrom: aString [
	"return a collection of pillar nodes which can be used in setChildren: of the owner of aString"
	^ (self splitString: aString) collect: [ :node | node asPillar ]
]

{ #category : #private }
MicIntraBlockSplitter >> spanAllOf: aString kind: kind [
	^ MicInlineBlock new
		string: aString;
		start: 1;
		end: aString size;
		next: aString size;
		kind: kind;
		yourself
]

{ #category : #private }
MicIntraBlockSplitter >> spanOn: aString from: start to: end next: next kind: kind [
	^ MicInlineBlock new
		string: aString;
		start: start;
		end: end;
		next: next;
		kind: kind;
		yourself
]

{ #category : #public }
MicIntraBlockSplitter >> splitString: aString [
	"Split aString into constituent markup nodes. A string is from a single line.
	return an array of inlineBlocks"
	| start block rest |
	start := aString indexOfAnyOf: self startSet.
	start = 0
		ifTrue: [ ^ {(self spanAllOf: aString kind: #plain)} ].
	block := self matchMarkdownIn: aString at: start.
	( block isNil or: [block end = 0])
		ifTrue: [ ^ {(self spanAllOf: aString kind: #plain)} ].
	rest := #().
	block next <= aString size
		ifTrue: [ rest := self
				splitString: (aString copyFrom: block next to: aString size) ].
	^ {(self
		spanOn: aString
		from: 1
		to: start - 1
		next: start
		kind: #plain).
	block split} , rest
]

{ #category : #private }
MicIntraBlockSplitter >> startSet [
	^'*_~¨`[!'.
]
