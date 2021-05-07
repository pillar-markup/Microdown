Class {
	#name : #MicConverterVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'pillarDocument',
		'visitor'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #tests }
MicConverterVisitorTest >> parserClass [
	^ MicroDownParser
]

{ #category : #initialization }
MicConverterVisitorTest >> setUp [
 	super setUp.
 	visitor := MicPillarConverterOnUnexpandedBloc new
]

{ #category : #tests }
MicConverterVisitorTest >> testCodeBlock [

	| document |
	document := self parserClass new parse: '```language=pharo
	1-2 
```'.
	self assert: (document accept: visitor) children first class equals: PRCodeblock.
	
]

{ #category : #tests }
MicConverterVisitorTest >> testCodeInText [

	| document |
	document := self parserClass new parse: 'The method `foo` is fun'.
	pillarDocument := document accept: visitor.
	self assert: pillarDocument children first class equals: PRParagraph.
	self assert: pillarDocument children first children second class equals: PRMonospaceFormat 
	
	
]

{ #category : #tests }
MicConverterVisitorTest >> testHeader [ 

	| document |
	document := self parserClass new parse: '# Header1
	
## Header 2
	
### Header 3'.
	pillarDocument := document accept: visitor.
	"we could have use Grammar headerMarkup to build the text but this is clearer like that"
	self assert: pillarDocument children first class equals: PRHeader.
	self assert: pillarDocument children third class equals: PRHeader.
	self assert: pillarDocument children fifth class equals: PRHeader
	
]

{ #category : #tests }
MicConverterVisitorTest >> testMathBlock [
	| source root pillar |
	source := '
&
V_i = C_0 - C_3
&
	
'.
	root := self parserClass new parse: source.
	pillar := root children first accept: visitor.
	self assert: pillar class equals: PRMathEnvironment.
	self assert: pillar children first class equals: PRText.
	
]

{ #category : #tests }
MicConverterVisitorTest >> testNumberedList [
	| document |
	document := (self parserClass new 
		parse: MicMicroDownSnippetFactory new orderedListWithTwoItemsSample).
	document := document accept: visitor.
	self assert: document children first class equals: PROrderedList.
	self
		assert: document children first children first class
		equals: PRListItem.
	self
		assert: document children first children second class
		equals: PRListItem
]

{ #category : #tests }
MicConverterVisitorTest >> testRoot [
	| source root pillar |
	source := '####    Level four
## Level 2'.
	root := self parserClass new parse: source.
	pillar := root accept: visitor.
	self assert: pillar class equals: PRDocument.
	self assert: pillar children second class equals: PRHeader.
	self assert: pillar children first level equals: 4
]

{ #category : #tests }
MicConverterVisitorTest >> testSingleLevelOrderedList2 [
	| source root list |
	source := '19. item 1
    expanded
7.  item 2'.
	root := self parserClass new parse: source.
	list := root children first accept: visitor.
	self assert: list class equals: PROrderedList .
	self assert: list children size equals: 2.
	self
		assert: list children first text
		equals:
			'item 1
expanded'.
	self assert: list counter equals: 19
]

{ #category : #tests }
MicConverterVisitorTest >> testSingleLevelUnorderedList2 [
	| source root list item |
	source := '- item 1
  expanded
- item 2'.
	root := self parserClass new parse: source.
	list := root children first accept: visitor.
	self assert: list class equals: PRUnorderedList.
	self assert: list children size equals: 2.
	item := list children first.
	self assert: item class equals: PRListItem.
	self
		assert: item children first text
		equals:
			'item 1
expanded'
]

{ #category : #tests }
MicConverterVisitorTest >> testSingleParagraphWithIndentedText [
	| source root expected pillar |
	source := 'This is
   a paragraph with spaces
	and one with tabs'.
	expected := 'This is
a paragraph with spaces
and one with tabs'.
	root := self parserClass new parse: source.
	pillar := root children first accept: visitor.
	self assert: pillar class equals: PRParagraph.
	self assert: pillar children first class equals: PRText.
	self assert: pillar children first text equals: expected
]

{ #category : #tests }
MicConverterVisitorTest >> testTwoLevelUnorderedList1 [
	| source root list secondItem subItem |
	source := '- item 1
  - sublevel
- item 2'.
	root := self parserClass new parse: source.
	list := root children first accept: visitor.
	secondItem := list children second.
	self assert: secondItem class equals: PRListItem.
	self assert: secondItem children first class equals: PRText.
	self assert: secondItem children first text equals: 'item 2'.
	subItem := list children first children second.
	self assert: subItem class equals: PRUnorderedList.
	self
		assert: subItem children first text
		equals: 'sublevel'	"item 1"	"unorded list"	"sub item"
]
