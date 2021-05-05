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
	self skip.
	elements := (self parseAndReturnElementsOfParagraphFor: 'abc`monospaces`def').
	self assert: elements size equals: 3.
	self assert: elements first substring equals: 'abc'.
	self assert: elements second substring equals: 'monospaces'.
	self assert: elements second kind equals: 'monospace'.
	self assert: elements second openingDelimiter equals: '`'
]
