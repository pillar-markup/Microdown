Class {
	#name : #MicroDownInlineParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #parsing }
MicroDownInlineParserTest >> parse: aString [
 	"self new parse: 'foo_abbb_zz' "
 	| contents doc elements |
 	doc := (MicroDownParser parse: aString).
 	contents := doc  children first text.
 	elements := MicInlineSplitter new start: contents.
 	doc children: { (MicParagraphBlock new children: elements)}. 
 	^ doc
]

{ #category : #parsing }
MicroDownInlineParserTest >> parseAndReturnElementsOfParagraphFor: aString [ 
 	"self new parse: 'foo_abbb_zz' "
 	^ (self parse: aString) children first children
 
]

{ #category : #parsing }
MicroDownInlineParserTest >> testItalics [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc_italics_def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'italics'.
 	self assert: elements second kind equals: 'italic'.
 	self assert: elements second openingDelimiter equals: '_'
]
