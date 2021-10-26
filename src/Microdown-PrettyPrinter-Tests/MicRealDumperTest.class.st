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

	| mic result |
	mic := parser parse: aString.
	result := (visitor visit: mic children first).
	self assert: result contents equals: anExpectedString
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

	| micBold result |
	micBold := (parser parse: factory boldFormatSample) children first children first.
	result := (micBold accept: visitor).
	self assert: result contents equals: 'MicBoldFormatBlock "Foo"'
	

]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testComment [

	| micComment result |
	micComment := (parser parse: factory commentSample) children first.
	result := (micComment accept: visitor).
	self assert: result contents equals: 'MicCommentBlock "Foo"'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testFigureFormat [

	| micFigure result |
	micFigure := (parser parse: factory figureSample) children first children first.
	result := (micFigure accept: visitor).
	self assert: result contents equals:'MicFigureBlock parameters:label=figureTest&size=80 url:/anUrl?label=figureTest&size=80 "Foo"'
	
]

{ #category : #'tests - section' }
MicRealDumperTest >> testHeader [

	| resString |
	resString := '(MicHeaderBlock new level: 3; header: ''Foo'')'.
	self parse: factory headerLevel3Sample andCheckWeGet: resString
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testItalicFormat [

	| micItalic result |
	micItalic := (parser parse: factory italicFormatSample) children first children first.
	result := (micItalic accept: visitor).
	self assert: result contents equals: 'MicItalicFormatBlock "Foo"'

]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testLinkFormat [

	| micLink result |
	micLink := (parser parse: factory linkSample) children first children first.
	result := (micLink accept: visitor).
	self assert: result contents equals: 'MicLinkBlock url:/anUrl "Foo"'

	
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testMonospaceFormat [

	| mic result |
	mic := parser parse: factory monospaceFormatSample.
	result := (visitor visit: mic children first children first).
	self assert: result contents equals: 'MicMonospaceFormatBlock "Foo"'
	
]

{ #category : #'tests - section' }
MicRealDumperTest >> testOrderedList [

	| resString |
	resString := 'MicOrderedListBlock'.
	self parse: factory orderedListSample andCheckWeGet: resString
]

{ #category : #'tests - section' }
MicRealDumperTest >> testParagraph [

	| resString |
	resString := '(MicParagraphBlock new )'.
	self parse: factory paragraphSample andCheckWeGet: resString
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testQuote [

	| micQuote |
	micQuote := (parser parse: factory quoteSample) children first.
	self assert: (micQuote accept: visitor) equals: 'MicQuoteBlock "Foo"'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testRawBlock [

	| micRaw |
	micRaw := (parser parse: factory rawFormatSample) children first
		          children second.
	self assert: (micRaw accept: visitor) equals: 'MicRawBlock "Foo"'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testStrike [


	| micStrike result |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	result := micStrike accept: visitor.
	self assert: result contents equals: 'MicStrikeFormatBlock "Foo"'

]

{ #category : #'tests - section' }
MicRealDumperTest >> testTable [

	| micTable |
	micTable := (parser parse: factory tableSample) children first.
	self assert: (micTable accept: visitor) equals: 'MicTableBlock'
]

{ #category : #'test - inline - blocks' }
MicRealDumperTest >> testTextBlock [

	| micText |
	micText := (parser parse: factory headerLevel3Sample) children first
		           children first.
	self assert: (micText accept: visitor) equals: 'MicTextBlock "Foo"'
]

{ #category : #'tests - section' }
MicRealDumperTest >> testUnorderedList [

	| resString |
	resString := 'MicUnorderedListBlock'.
	self parse: factory unorderedListSample andCheckWeGet: resString
]

{ #category : #accessing }
MicRealDumperTest >> visitor [

	^ visitor
]

{ #category : #accessing }
MicRealDumperTest >> visitor: anObject [

	visitor := anObject
]
