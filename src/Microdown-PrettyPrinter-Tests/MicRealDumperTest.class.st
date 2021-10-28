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

{ #category : #tests }
MicRealDumperTest class >> testParameters [ 
	^ super testParameters
			addCase: { #visitor -> MicDumper };
		yourself.
]

{ #category : #accessing }
MicRealDumperTest >> factory [ 
	^ factory
]

{ #category : #accessing }
MicRealDumperTest >> factory: aFactory [
	factory := aFactory
]

{ #category : #'tests - section' }
MicRealDumperTest >> parse: aString andCheckWeGet: anExpectedString [

	| mic |
	mic := parser parse: aString.
	visitor visit: mic children first.
	self assert: visitor contents equals: anExpectedString
]

{ #category : #'tests - section' }
MicRealDumperTest >> recreateFrom: aString sameObjectAs: resString [
	
	| origObject resObject |
	origObject := parser parse: aString.
	resObject := OpalCompiler new source: resString; evaluate.
	self assert: origObject equals: resObject
]

{ #category : #running }
MicRealDumperTest >> setUp [
	super setUp.
	factory := MicMicrodownSnippetFactory new.
	visitor := MicRealDumper new.
	parser := MicroDownParser new
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

	| micCodeBlock |
	self skip.
	micCodeBlock := parser parse: factory blockSampleOnMultipleLines.
	self
		assert: (micCodeBlock accept: visitor)
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
	self skip.
	micFigure := (parser parse: factory figureSample) children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock parameters:label=figureTest&size=80 url:/anUrl?label=figureTest&size=80 ''Foo'')'
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
		'(MicHeaderBlocklevel: header: new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testItalicFormat [

	| micItalic result |
	micItalic := (parser parse: factory italicFormatSample) children
		             first children first.
	result := micItalic accept: visitor.
	self
		assert: result contents
		equals: '(MicItalicFormatBlock new string: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testLinkFormat [

	| micLink result |
	self skip.
	micLink := (parser parse: factory linkSample) children first children
		           first.
	self assert: micLink class equals: MicLinkBlock.
	result := micLink accept: visitor.
	self
		assert: result contents
		equals: '(MicLinkBlock ''[Foo](/anUrl)'')'
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
	micList := (parser parse: factory orderedListSample) children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testParagraph [

	| resString |
	resString := '(MicParagraphBlock new textElement: (MicTextBlock new substring: ''Foo''))'.
	self parse: factory paragraphSample andCheckWeGet: resString
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
	self flag: #tofix.
	self skip.
	"it seems that children elements of raw are in substring and not in the children"
	micRaw := (parser parse: factory rawFormatSample) children first
		          children second.
	self assert: micRaw class equals: MicRawBlock.
	visitor visit: micRaw.
	self
		assert: visitor contents
		equals:
		'(MicRawBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testStrike [


	| micStrike result |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	result := micStrike accept: visitor.
	self assert: result contents equals: '(MicStrikeFormatBlock new string: (MicTextBlock new substring: ''Foo''))'

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
MicRealDumperTest >> testUnOrderedList [

	| micList |
	self skip.
	micList := (parser parse: factory unorderedListSample) children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnOrderedListBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : #accessing }
MicRealDumperTest >> visitor [

	^ visitor
]

{ #category : #accessing }
MicRealDumperTest >> visitor: anObject [

	visitor := anObject
]
