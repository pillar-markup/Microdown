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
MicroDownInlineParserTest >> testFigure [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc![caption](url?parameters=value)def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'caption'.
 	self assert: elements second kind equals: 'figure'.
 	self assert: elements second openingDelimiter equals: '!['.
 	self assert: elements second closingDelimiter equals: ')'
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
MicroDownInlineParserTest >> testLink [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc[caption](url?parameters=value)def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'caption'.
 	self assert: elements second kind equals: 'linkName'.
 	self assert: elements second openingDelimiter equals: '['.
 	self assert: elements second closingDelimiter equals: ')'
]

{ #category : #tests }
MicroDownInlineParserTest >> testMath [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc$V_i = C_0 - C_3$def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'V_i = C_0 - C_3'.
 	self assert: elements second kind equals: 'math'.
 	self assert: elements second openingDelimiter equals: '$'
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

{ #category : #tests }
MicroDownInlineParserTest >> testStrikes [
 	| elements |
 	elements := (self parseAndReturnElementsOfParagraphFor: 'abc~strikes~def').
 	self assert: elements size equals: 3.
 	self assert: elements first substring equals: 'abc'.
 	self assert: elements second substring equals: 'strikes'.
 	self assert: elements second kind equals: 'strike'.
 	self assert: elements second openingDelimiter equals: '~'
]
