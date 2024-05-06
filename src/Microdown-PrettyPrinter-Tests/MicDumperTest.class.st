Class {
	#name : 'MicDumperTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'factory',
		'visitor',
		'parser'
	],
	#category : 'Microdown-PrettyPrinter-Tests',
	#package : 'Microdown-PrettyPrinter-Tests'
}

{ #category : 'tests - section' }
MicDumperTest >> parse: aString andCheckWeGet: anExpectedString [

	| mic |
	mic := parser parse: aString.
	visitor visit: mic children first.
	self assert: visitor contents equals: anExpectedString
]

{ #category : 'running' }
MicDumperTest >> setUp [ 
	super setUp.
	parser := Microdown new.
	factory := MicMicrodownSnippetFactory new.
	visitor := MicRealDumper new.
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testAnchorFormat [

	| micAnchor result |
	micAnchor := parser parse: factory anchorSample.
	result := visitor visit: micAnchor children first.
	self
		assert: result contents
		equals: '(MicAnchorBlock new textElement: " test ")'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testBold [

	self 
		assert: (MicRealDumper new 
						visit: (Microdown parse: '**aaa_bbb_ccc**')) contents  
						
		equals: '(MicParagraphBlock new textElements: {(MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''aaa'') . (MicItalicFormatBlock new textElements: {(MicTextBlock new substring: ''bbb'')}) . (MicTextBlock new substring: ''ccc'')})})'
						
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testBoldFormat [

	| micBold |
	micBold := (parser parse: factory boldFormatSample) children first
		           children first.
	self assert: micBold children first class equals: MicTextBlock. 
	visitor visit: micBold.
	self
		assert: visitor contents
		equals:
		'(MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockNewLine [

	| micCodeBlock result |
	micCodeBlock := (parser parse: factory blockWithNewLineSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals: '(MicCodeBlock new body: ''foo'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockOnMultipleLines [

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

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithCaption [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockWithParametersWithCaptionSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #caption ->''Color is beautifull'' . #bar ->2 } asDictionary ; body: ''bla'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithFloatParam [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockWithParameterWithFloatSample) children
		                first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals: '(MicCodeBlock new arguments: { #ratio ->0.8 } asDictionary ; body: ''bar'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithLanguage [

	| micCodeBlock result |
	micCodeBlock := (parser parse: factory blockWithLanguageSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #language ->smalltalk } asDictionary ; body: ''foo'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithLiteralArray [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockParameterWithLiteralArraySample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #foo ->#(1 2 true) } asDictionary ; )'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithNoValues [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockWithParameterWithNoValuesSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #foo -> } asDictionary ; body: ''bar'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithParameterTrueByDefault [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockWithParameterTrueByDefaultSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals: '(MicCodeBlock new arguments: { #language ->foo } asDictionary ; body: ''bar'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithParameters [

	| micCodeBlock result |
	micCodeBlock := (parser parse: factory blockWithParametersSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #foo ->true . #bar ->2 } asDictionary ; body: ''bla'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithSpaceAtTheEnd [

	| micCodeBlock result |
	micCodeBlock := (parser parse: factory blockWithSpaceAtTheEndSample)
		                children first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new body: ''foo'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithSpacedParameters [

	| micCodeBlock result |
	micCodeBlock := (parser parse:
		                 factory blockWithSpacedParametersSample) children
		                first.
	result := micCodeBlock accept: visitor.
	self
		assert: result contents
		equals:
		'(MicCodeBlock new arguments: { #foo -> true  . #bar -> 2 } asDictionary ; body: ''bla'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testCodeBlockWithoutParam [

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

{ #category : 'test - inline - blocks' }
MicDumperTest >> testComment [

	| micComment |  
	micComment := (parser parse: factory commentSample) children first.
	self assert: micComment class equals: MicCommentBlock.
	visitor visit: micComment.
	
	self
		assert: visitor contents
		equals: '(MicCommentBlock new textElement: ''Foo'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureBoldFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureBoldSample) children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		 equals: '(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})}; yourself)'
		
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureBoldFormat2 [

	| micFigure result |
	micFigure := (parser parse: '![**Bold** and not bold and **bold**](/anUrl label=figureTest&size=80)') children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents 
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #size ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''Bold'')}) . (MicTextBlock new substring: '' and not bold and '') . (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''bold'')})}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureSample) children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicTextBlock new substring: ''Foo'')}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureItalicFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureItalicSample) children
		             first children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicItalicFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureMonospaceFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureMonospaceSample) children
		             first children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents 
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicMonospaceFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureNestedFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureNestedSample) children
		             first children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''Foo_'')})}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFigureStrikeFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureStrikeSample) children
		             first children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents  
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''/anUrl'' ; caption: { (MicStrikeFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})}; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testFileFigureFormat [

	| micFigure result |
	micFigure := (parser parse: factory fileFigureSample) children first
		             children first.
	self assert: micFigure class equals: MicFigureBlock.
	result := micFigure accept: visitor.
	self
		assert: result contents
		equals:
		'(MicFigureBlock new arguments: { #label ->figureTest . #width ->80 } asDictionary ; url: ''image.png/'' ; caption: { (MicTextBlock new substring: ''Foo'')}; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testHeader [

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

{ #category : 'test - inline - blocks' }
MicDumperTest >> testItalicFormat [

	| micItalic result |
	micItalic := (parser parse: factory italicFormatSample) children
		             first children first.
	result := micItalic accept: visitor.
	self
		assert: result contents
		equals: '(MicItalicFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testMonospaceFormat [

	| mic result |
	mic := parser parse: factory monospaceFormatSample.
	result := visitor visit: mic children first children first.
	self
		assert: result contents
		equals: '(MicMonospaceFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedList [

	| micList |

	micList := (parser parse: factory orderedListSample) children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''Foo'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedListWithTwoItems [

	| micList |
	micList := (parser parse: factory orderedListWithTwoItemsSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''first'')) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedListWithTwoItemsBold [

	| micList |
	micList := (parser parse: factory orderedListWithTwoItemsBoldSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''first'')})) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedListWithTwoItemsItalic [

	| micList |
	
	micList := (parser parse: factory orderedListWithTwoItemsItalicSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicItalicFormatBlock new textElements: {(MicTextBlock new substring: ''first'')})) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedListWithTwoItemsMonospace [

	| micList |
	micList := (parser parse: factory orderedListWithTwoItemsMonospaceSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicMonospaceFormatBlock new textElement: (MicTextBlock new substring: ''first''))) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testOrderedListWithTwoItemsStrike [

	| micList |
	micList := (parser parse: factory orderedListWithTwoItemsStrikeSample)
		           children first.
	self assert: micList class equals: MicOrderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicOrderedListBlock new children: { (MicListItemBlock new (MicStrikeFormatBlock new textElements: {(MicTextBlock new substring: ''first'')})) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testParagraph [

	| resString |
	resString := '(MicParagraphBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory paragraphSample andCheckWeGet: resString
]

{ #category : 'tests - section' }
MicDumperTest >> testPrintHeader [
	
	| resString |
	resString := '(MicHeaderBlock new level: 3; headerElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory headerLevel3Sample andCheckWeGet: resString.
	
	
	


]

{ #category : 'tests - section' }
MicDumperTest >> testPrintOrderedList [

	| resString |
	resString := '(MicOrderedListBlock new children: { (MicListItemBlock new (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''first'')})) . (MicListItemBlock new (MicTextBlock new substring: ''second'')) }; yourself)'.
	self
		parse: factory orderedListWithTwoItemsBoldSample
		andCheckWeGet: resString
]

{ #category : 'tests - section' }
MicDumperTest >> testPrintParagraph [

	| resString |
	resString := '(MicParagraphBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'.
	self parse: factory paragraphSample andCheckWeGet: resString
]

{ #category : 'tests - section' }
MicDumperTest >> testPrintUnorderedList [

	| resString |
	resString := '(MicUnorderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''Foo'')) }; yourself)'.
	self parse: factory unorderedListSample andCheckWeGet: resString
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testQuote [

	| micQuote |
	micQuote := (parser parse: factory quoteSample) children first.
	self assert: micQuote children first class equals: MicTextBlock.
	visitor visit: micQuote.
	self
		assert: visitor contents
		equals:
		'(MicBlockQuoteBlock new textElement: (MicTextBlock new substring: ''Foo''))'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testRawBlock [

	| micRaw |
	micRaw := (parser parse: factory rawFormatSample) children first children second.
	self assert: micRaw class equals: MicRawBlock.
	visitor visit: micRaw.
	self
		assert: visitor contents
		equals:
		'(MicRawBlock new substring: ''Foo'')'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testSimpleLinkFormat [

	| micLink result |
	micLink := (parser parse: '[Pharo url](http://www.pharo.org)') children first children first.
	self assert: micLink class equals: MicLinkBlock.
	result := micLink accept: visitor.
	self
		assert: result contents
		equals: '(MicLinkBlock new captionElements: {(MicTextBlock new substring: ''Pharo url'')} ; url: ''http://www.pharo.org'' ; yourself)'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testStrike [


	| micStrike result |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	result := micStrike accept: visitor.
	self assert: result contents equals: '(MicStrikeFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})'

]

{ #category : 'tests - section' }
MicDumperTest >> testTable [

	| micTable |
	self skip.
	micTable := (parser parse: factory tableSample) children first.
	self assert: (micTable accept: visitor) equals: 'MicTableBlock'
]

{ #category : 'test - inline - blocks' }
MicDumperTest >> testTextBlock [

	| micText |
	micText := (parser parse: factory textSentenceSample) children first
		           children first.
	visitor visit: micText.
	self
		assert: visitor contents
		equals:
		'(MicTextBlock new substring: ''Je ne connaitrais pas la peur'')'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedEmptyList [

	| micList |
	micList := (parser parse: factory unorderedListEmptySample) children
		           first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''-'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedList [

	| micList |
	micList := (parser parse: factory unorderedListSample) children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents 
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''Foo'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedListWithTwoItems [

	| micList |
	micList := (parser parse: factory unorderedListWithTwoItemsSample)
		           children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicTextBlock new substring: ''Foo'')) . (MicListItemBlock new (MicTextBlock new substring: ''Bar'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedListWithTwoItemsBold [

	| micList |
	micList := (parser parse: factory unorderedListWithTwoItemsBoldSample)
		           children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicBoldFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})) . (MicListItemBlock new (MicTextBlock new substring: ''Bar'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedListWithTwoItemsMonospace [

	| micList |
	
	micList := (parser parse:
		            factory unorderedListWithTwoItemsMonospaceSample) children
		           first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicMonospaceFormatBlock new textElement: (MicTextBlock new substring: ''Foo''))) . (MicListItemBlock new (MicTextBlock new substring: ''Bar'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedListWithTwoItemsNested [

	| micList |
	
	micList := (parser parse:
		            factory unorderedListWithTwoItemsNestedSample) children
		           first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicStrikeFormatBlock new textElements: {(MicItalicFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})})) . (MicListItemBlock new (MicTextBlock new substring: ''Bar'')) }; yourself)'
]

{ #category : 'tests - section' }
MicDumperTest >> testUnOrderedListWithTwoItemsStrike [

	| micList |
	
	micList := (parser parse: factory unorderedListWithTwoItemsStrikeSample )
		           children first.
	self assert: micList class equals: MicUnorderedListBlock.
	visitor visit: micList.
	self
		assert: visitor contents
		equals:
		'(MicUnorderedListBlock new children: { (MicListItemBlock new (MicStrikeFormatBlock new textElements: {(MicTextBlock new substring: ''Foo'')})) . (MicListItemBlock new (MicTextBlock new substring: ''Bar'')) }; yourself)'
]
