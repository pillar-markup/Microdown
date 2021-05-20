Class {
	#name : #MicPrettyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'visitor',
		'parser'
	],
	#category : #'Microdown-PrettyPrinter-Tests'
}

{ #category : #accessing }
MicPrettyPrinterTest >> factory [ 
	^ factory
]

{ #category : #accessing }
MicPrettyPrinterTest >> factory: aFactory [
	factory := aFactory
]

{ #category : #running }
MicPrettyPrinterTest >> setUp [
	super setUp.
	factory := MicMicroDownSnippetFactory new.
	visitor := MicPrettyPrinter new.
	parser := MicroDownParser new
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintAnchor [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintCode [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintComment [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintHeader [
| micHeader |
	micHeader := (parser parse: factory headerLevel3Sample) children first.
	self assert: (micHeader accept: visitor) equals: 'MicHeaderBlock level:3 "Foo"'
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintHorizontalLine [
	| micHorizontalLine |
	micHorizontalLine := (parser parse: factory horizontalLineSample) children first.
	self assert: (micHorizontalLine accept: visitor) equals: 'MicHorizontalLineBlock'
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintListItem [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintMath [
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicAnchorReferenceBlock [
	| micAnchorReference |
	micAnchorReference := (parser parse: factory anchorReferenceSample) children first children first.
	self assert: (micAnchorReference accept: visitor) equals: 'MicAnchorReferenceBlock "Foo"'.


]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintMicAnnotated [
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicAnnotationBlock [
	| micAnnotation |
	micAnnotation := (parser parse: factory annotationSample) children first children second.
	self assert: (micAnnotation accept: visitor) equals: 'MicAnnotationBlock "Foo | value=aFoo&label=42"'
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicBoldFormatBlock [
	| micBold |
	micBold := (parser parse: factory boldFormatSample) children first children first.
	self assert: (micBold accept: visitor) equals: 'MicBoldFormatBlock "Foo"'

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicFigureBlock [
	| micFigure |
	micFigure := (parser parse: factory figureSample) children first children first.
	self assert: (micFigure accept: visitor) equals: 'MicFigureBlock parameters:label=figureTest&size=80 url:/anUrl "Foo"'

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicItalicFormatBlock [
	| micItalic |
	micItalic := (parser parse: factory italicFormatSample) children first children first.
	self assert: (micItalic accept: visitor) equals: 'MicItalicFormatBlock "Foo"'

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicLinkBlock [
	| micLink |
	micLink := (parser parse: factory linkSample) children first children first.
	self assert: (micLink accept: visitor) equals: 'MicLinkBlock url:/anUrl "Foo"'

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicMathInlineBlock [
	| micMathInline |
	micMathInline := (parser parse: factory mathInlineSample) children first children first.
	self assert: (micMathInline accept: visitor) equals: 'MicMathInlineBlock "V_i = C_0 - C_3"'
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicMonospaceFormatBlock [
	| micMonospace |
	micMonospace := (parser parse: factory monospaceFormatSample) children first children first.
	self assert: (micMonospace accept: visitor) equals: 'MicMonospaceFormatBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicRawBlock [
	| micRaw |
	micRaw := (parser parse: factory rawFormatSample) children first children second.
	self assert: (micRaw accept: visitor) equals: 'MicRawBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicStrikeFormatBlock [
	| micStrike |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	self assert: (micStrike accept: visitor) equals: 'MicStrikeFormatBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicTextBlock [
	| micText |
	micText := (parser parse: factory headerLevel3Sample) children first children first.
	self assert: (micText accept: visitor) equals: 'MicTextBlock "Foo"'.

]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintOrderedList [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintParagraph [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintQuote [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintRoot [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintTable [
]

{ #category : #'tests-block' }
MicPrettyPrinterTest >> testPrintUnorderedList [
]
