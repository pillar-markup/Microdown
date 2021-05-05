Class {
	#name : #MicroDownInlineParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #tests }
MicroDownInlineParserTest >> parse: aString [
	"self new parse: 'foo_abbb_zz' "
	| contents doc elements |
	doc := (MicroDownParser parse: aString).
	contents := doc  children first text.
	elements := MicInlineSplitter new start: contents.
	doc children: { (MicParagraphBlock new children: elements)}. 
	^ doc
]

{ #category : #tests }
MicroDownInlineParserTest >> parseAndReturnElementsOfParagraphFor: aString [
	"self new parse: 'foo_abbb_zz' "
	^ (self parse: aString) children first children
]

{ #category : #tests }
MicroDownInlineParserTest >> testAnchor [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc*@anchors@*def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'anchors'.
	self assert: elements second kind equals: 'anchorReference'.
	self assert: elements second openingDelimiter equals: '*@'.
	self assert: elements second closingDelimiter equals: '@*'
]

{ #category : #tests }
MicroDownInlineParserTest >> testAnnotations [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc<?footnote | value=A foonote is anannotation.?>def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'footnote | value=A foonote is anannotation.'.
	self assert: elements second kind equals: 'annotation'.
	self assert: elements second openingDelimiter equals: '<?'.
	self assert: elements second closingDelimiter equals: '?>'
]

{ #category : #tests }
MicroDownInlineParserTest >> testBolds [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc**bolds**def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'bolds'.
	self assert: elements second kind equals: 'bold'.
	self assert: elements second openingDelimiter equals: '**'
]

{ #category : #tests }
MicroDownInlineParserTest >> testEscape [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc\_bolds_def').
	self assert: elements size equals: 1.
	self assert: elements first substring equals: 'abc_bolds_def'.
	self assert: elements first kind equals: 'basic'.
]

{ #category : #tests }
MicroDownInlineParserTest >> testItalics [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc_italics_def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'italics'.
	self assert: elements second kind equals: 'italic'.
	self assert: elements second openingDelimiter equals: '_'
]

{ #category : #tests }
MicroDownInlineParserTest >> testMonospaces [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc`monospaces`def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'monospaces'.
	self assert: elements second kind equals: 'monospace'.
	self assert: elements second openingDelimiter equals: '`'
]

{ #category : #tests }
MicroDownInlineParserTest >> testRaws [
	| elements |
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc{{raws}}def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'raws'.
	self assert: elements second kind equals: 'raw'.
	self assert: elements second openingDelimiter equals: '{{'.
	self assert: elements second closingDelimiter equals: '}}'
]
