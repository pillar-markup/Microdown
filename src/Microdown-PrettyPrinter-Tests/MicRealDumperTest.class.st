Class {
	#name : #MicRealDumperTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'factory',
		'visitor',
		'parser'
	],
	#category : #'Microdown-PrettyPrinter-Tests'
}

{ #category : #'tests - section' }
MicRealDumperTest >> parse: aString andCheckWeGet: anExpectedString [

	| mic |
		self skip.
	self flag: #lyna.
	mic := parser parse: aString.
	visitor visit: mic children first.
	self assert: visitor contents equals: anExpectedString
]

{ #category : #running }
MicRealDumperTest >> setUp [ 
	super setUp.
	parser := MicroDownParser new.
	factory := MicMicrodownSnippetFactory new.
	visitor := MicRealDumper new.
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testBoldFormat [

	| micBold |
	micBold := (parser parse: factory boldFormatSample) children first
		           children first.
	self assert: micBold children first class equals: MicTextBlock.
	visitor visit: micBold.
	self
		assert: visitor contents
		equals:
		'(MicBoldFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testCodeBlockWithoutParam [

	| micCodeBlock result |
	micCodeBlock := (parser parse: factory blockSampleOnMultipleLines)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals: '(MicCodeBlock new body: ''first line 
second line
third line **b**'')'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testComment [

	| micComment |  
	micComment := (parser parse: factory commentSample) children first.
	self assert: micComment class equals: MicCommentBlock.
	visitor visit: micComment.
	
	self
		assert: visitor contents
		equals: '(MicCommentBlock new textElement: ''Foo'')'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testFigureFormat [

	| micFigure result |

	micFigure := (parser parse: factory figureSample) children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock parameters: label=figureTest&size=80 url: /anUrl?label=figureTest&size=80 ''Foo'')'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testHeader [

	| micHeader |
	micHeader := (parser parse: factory headerLevel3Sample) children
		             first.
	self assert: micHeader class equals: MicHeaderBlock.
	self assert: micHeader children first class equals: MicTextBlock.
	visitor visit: micHeader.
	self
		assert: visitor contents
		equals:
		'(MicHeaderBlock new level: 3; headerElements: {(MicTextBlock new substring: ''Foo'')})'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testItalicFormat [

	| micItalic result |
	micItalic := (parser parse: factory italicFormatSample) children
		             first children first.
	result := micItalic accept: visitor.
	self
		assert: result contents
		equals: '(MicItalicFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testLinkFormat [

	| micLink result |
	micLink := (parser parse: factory linkSample) children first children
		           first.
	self assert: micLink class equals: MicLinkBlock.
	result := micLink accept: visitor.
	self
		assert: result contents
		equals: '(MicLinkBlock new textElement: [Foo](/anUrl)'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testMonospaceFormat [

	| mic result |
	mic := parser parse: factory monospaceFormatSample.
	result := visitor visit: mic children first children first.
	self assert: result contents equals: '(MicMonospaceFormatBlock new string: ''Foo'')'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedList [

	| micList |
	self skip.
	self flag: #lyna.
	micList := (parser parse: factory orderedListSample) children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedListWithTwoItems [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory orderedListWithTwoItemsSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicTextBlock new substring: ''first'')(MicTextBlock new substring: ''second''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedListWithTwoItemsBold [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory orderedListWithTwoItemsBoldSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicBoldFormatBlock new textElement: (MicTextBlock new substring: ''first''))(MicTextBlock new substring: ''second''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedListWithTwoItemsItalic [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory orderedListWithTwoItemsItalicSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicItalicFormatBlock new string: (MicTextBlock new substring: ''first''))(MicTextBlock new substring: ''second''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedListWithTwoItemsMonospace [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory orderedListWithTwoItemsMonospaceSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicMonospaceFormatBlock new string: ''first'')(MicTextBlock new substring: ''second''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedListWithTwoItemsStrike [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse:
		            factory orderedListWithTwoItemsStrikeSample) children
		           first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new addChild: (MicStrikeFormatBlock new string: (MicTextBlock new substring: ''first''))(MicTextBlock new substring: ''second''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testParagraph [

	| resString |
	resString := '(MicParagraphBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory paragraphSample andCheckWeGet: resString
]

{ #category : #'tests - section' }
MicRealDumperTest >> testPrintHeader [
	
	| resString |
	resString := '(MicHeaderBlock new level: 3; headerElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory headerLevel3Sample andCheckWeGet: resString.
	
	
	


]

{ #category : #'tests - section' }
MicRealDumperTest >> testPrintOrderedList [

   | resString |
	resString := '(MicOrderedListBlock new children: {MicListItemBlock new textElements: { (MicBoldFormatBlock new textElement: (MicBoldFormatBlock new substring: ''first'')) . (MicBoldFormatBlock new substring: ''second'')})'.
	self parse: factory orderedListWithTwoItemsBoldSample andCheckWeGet: resString.
	
]

{ #category : #'tests - section' }
MicRealDumperTest >> testPrintParagraph [

	| resString |
	resString := '(MicParagraphBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory paragraphSample andCheckWeGet: resString.
	

]

{ #category : #'tests - section' }
MicRealDumperTest >> testPrintUnorderedList [

	| resString |
	resString := 'MicUnorderedListBlock'.
	self parse: factory unorderedListSample andCheckWeGet: resString.
	
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testQuote [

	| micQuote |
	micQuote := (parser parse: factory quoteSample) children first.
	self assert: micQuote children first class equals: MicTextBlock.
	visitor visit: micQuote.
	self
		assert: visitor contents
		equals:
		'(MicQuoteBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testRawBlock [

	| micRaw |
	self skip.
	micRaw := (parser parse: factory rawFormatSample) children first.
	self assert: micRaw class equals: MicRawBlock.
	visitor visit: micRaw.
	self
		assert: visitor contents
		equals:
		'(MicParagraphBlock new textElement: (MicTextBlock new substring: ''Foo'')))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testStrike [


	| micStrike result |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	result := micStrike accept: visitor.
	self assert: result contents equals: '(MicStrikeFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))'

]

{ #category : #'tests - section' }
MicRealDumperTest >> testTable [

	
	| micTable |
	self skip.
	
	micTable := (parser parse: factory tableSample) children first.
	self assert: (micTable accept: visitor) equals: 'MicTableBlock'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testTextBlock [

	| micText |
	micText := (parser parse: factory textSentenceSample) children first
		           children first.
	visitor visit: micText.
	self
		assert: visitor contents
		equals:
		'(MicTextBlock new substring: ''Je ne connaitrais pas la peur'')'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedEmptyList [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory unorderedListEmptySample) children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicTextBlock new substring: ''-''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedList [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory unorderedListSample) children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedListWithTwoItems [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory unorderedListWithTwoItemsSample) children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicTextBlock new substring: ''Foo'')(MicTextBlock new substring: ''Bar''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedListWithTwoItemsBold [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory unorderedListWithTwoItemsBoldSample)
		           children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicBoldFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))(MicTextBlock new substring: ''Bar''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedListWithTwoItemsMonospace [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse:
		            factory unorderedListWithTwoItemsMonospaceSample) children
		           first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicMonospaceFormatBlock new string: ''Foo'')(MicTextBlock new substring: ''Bar''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedListWithTwoItemsNested [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse:
		            factory unorderedListWithTwoItemsNestedSample) children
		           first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicStrikeFormatBlock new string: (MicItalicFormatBlock new string: (MicTextBlock new substring: ''Foo'')))(MicTextBlock new substring: ''Bar''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnOrderedListWithTwoItemsStrike [

	| micList |
		self skip.
	self flag: #lyna.
	micList := (parser parse: factory unorderedListWithTwoItemsStrikeSample )
		           children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new addChild: (MicStrikeFormatBlock new string: (MicTextBlock new substring: ''Foo''))(MicTextBlock new substring: ''Bar''))'
]
