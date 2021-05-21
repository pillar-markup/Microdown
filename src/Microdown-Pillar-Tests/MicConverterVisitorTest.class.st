Class {
	#name : #MicConverterVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'pillarDocument',
		'visitor',
		'factory'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #parsing }
MicConverterVisitorTest >> parse: sample createChildElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := (parser parse: sample) children first children first.
	pillarDoc := micDoc accept: visitor.
	self assert: pillarDoc class equals: aClass.
	^ pillarDoc
]

{ #category : #parsing }
MicConverterVisitorTest >> parse: sample createChildSecondElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := (parser parse: sample) children first children second.
	pillarDoc := micDoc accept: visitor.
	self assert: pillarDoc class equals: aClass.
	^ pillarDoc
]

{ #category : #parsing }
MicConverterVisitorTest >> parse: sample createElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := (parser parse: sample) children first.
	pillarDoc := micDoc accept: visitor.
	self assert: pillarDoc class equals: aClass.
	^ pillarDoc
]

{ #category : #tests }
MicConverterVisitorTest >> parserClass [
	^ MicroDownParser
]

{ #category : #initialization }
MicConverterVisitorTest >> setUp [
 	super setUp.
 	visitor := MicPillarConverter new.
	factory := MicMicroDownSnippetFactory new.
]

{ #category : #tests }
MicConverterVisitorTest >> testAnchorBlock [
	self parse: factory anchorSample createElementOfClass: PRAnchor
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testAnchorReference [
	self parse: factory anchorReferenceSample createChildElementOfClass: PRInternalLink
]

{ #category : #tests }
MicConverterVisitorTest >> testAnnotated [
	self parse: factory annotatedSample createElementOfClass: PRAnnotatedParagraph
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testAnnotation [
	self parse: factory annotationSample createChildSecondElementOfClass: PRUndefinedAnnotation
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testBoldFormat [
	self parse: factory boldFormatSample createChildElementOfClass: PRBoldFormat
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testBoldFormatEmpty [
	| boldBlock |
	self skip.
	self flag: #fixme.
	"the parser parse '****' and return a HorizontalBlock"
	boldBlock := self parse: factory boldFormatEmptySample createChildElementOfClass: PRBoldFormat.
	self assert: boldBlock text equals: ''
]

{ #category : #tests }
MicConverterVisitorTest >> testCodeBlock [
	self parse: (factory codeblock: 'language=pharo' body: '1-2 ') createElementOfClass: PRCodeblock

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
MicConverterVisitorTest >> testComment [
	self parse: factory commentSample createElementOfClass: PRCommentedLine
]

{ #category : #tests }
MicConverterVisitorTest >> testEnvironmentBlock [
	self skip.
	self flag: #fixme.
	"pillarFrom collect send to nil"
	self parse: factory environmentSample createElementOfClass: PREnvironment
	
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testFigure [
	self parse: factory figureSample createChildElementOfClass: PRFigure
]

{ #category : #tests }
MicConverterVisitorTest >> testHeader [ 
	self parse: factory headerLevel3Sample createElementOfClass: PRHeader
]

{ #category : #tests }
MicConverterVisitorTest >> testHorizontalLineBlock [
	self parse: factory horizontalLineSample createElementOfClass: PRHorizontalRule
	
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testItalicFormat [
	self parse: factory italicFormatSample createChildElementOfClass: PRItalicFormat
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testItalicFormatEmpty [
	| italicBlock |
	italicBlock := self parse: factory italicFormatEmptySample createChildElementOfClass: PRItalicFormat.
	self assert: italicBlock text equals: ''
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testLink [
	self parse: factory linkSample createChildElementOfClass: PRExternalLink
]

{ #category : #tests }
MicConverterVisitorTest >> testListItem [
	self parse: factory listMultiSample createChildElementOfClass: PRListItem
	
]

{ #category : #tests }
MicConverterVisitorTest >> testMathBlock [
	self parse: factory mathParametersSample createElementOfClass: PRMathEnvironment
	
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testMathInline [
	self parse: factory mathInlineSample createChildElementOfClass: PRMathInTextAnnotation
]

{ #category : #tests }
MicConverterVisitorTest >> testMetaDataBlock [
	self parse: factory metaDataSample createElementOfClass: PRMetadata
	
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testMonospaceFormat [
	self parse: factory monospaceFormatSample createChildElementOfClass: PRMonospaceFormat
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testMonospaceFormatEmpty [
	| monospaceBloc |
	monospaceBloc := self parse: factory monospaceFormatEmptySample createChildElementOfClass: PRMonospaceFormat.
	self assert: monospaceBloc text equals: ''
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
MicConverterVisitorTest >> testQuoteBlock [
	| source root pillarNode |
	source := '> text1
>    text2'.
	root := self parserClass new parse: source.
	self assert: root children size equals: 1.
	pillarNode := root children first accept: visitor.
	self assert: pillarNode class equals: PRPreformatted.
	self
		assert: pillarNode text
		equals:
			'text1
text2'
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testRawFormat [
	self skip.
	self flag: #fixme.
	"PRRaw don't understand setChildren"
	self parse: factory rawFormatSample createChildSecondElementOfClass: PRRaw
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

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testStrikethroughFormat [
	self parse: factory strikethroughFormatSample createChildElementOfClass: PRStrikethroughFormat
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testStrikethroughFormatEmpty [
	| strikeBlock |
	strikeBlock := self parse: factory strikethroughFormatEmptySample createChildElementOfClass: PRStrikethroughFormat.
	self assert: strikeBlock text equals: ''
]

{ #category : #'tests-inline blocks' }
MicConverterVisitorTest >> testText [
	| source root pillar |
	source := 'Foo'.
	root := (self parserClass new parse: source) children first children first.
	pillar := root accept: visitor.
	self assert: pillar class equals: PRText
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
