Class {
	#name : #MicTextualMicrodownExporterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'factory',
		'visitor',
		'visitorClass',
		'parser'
	],
	#category : #'Microdown-PrettyPrinter-Tests'
}

{ #category : #tests }
MicTextualMicrodownExporterTest class >> testParameters [ 
	^ super testParameters
			addCase: { #visitorClass -> MicTextualMicrodownExporter };
		yourself.
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> factory [ 
	^ factory
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> factory: aFactory [
	factory := aFactory
]

{ #category : #running }
MicTextualMicrodownExporterTest >> setUp [
	super setUp.
	factory := MicMicroDownSnippetFactory new.
	visitor := self visitorClass new.
	parser := MicroDownParser new
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testAnchorAutomatic [
	self verifyObtain: factory anchorSample
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintAnchor [
	| micAnchor |
	micAnchor := (parser parse: factory anchorSample).
	self assert: (visitor visit: micAnchor) equals: factory anchorSample
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintCode [
	| micCode |
	micCode := (parser parse: (factory codeblock: 'smalltalk&label=42' body: 'Foo')) children first.
	self assert: (micCode accept: visitor) equals: 'MicCodeBlock parameters:smalltalk&label=42 "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintComment [
	| micComment |
	micComment := (parser parse: factory commentSample) children first.
	self assert: (micComment accept: visitor) equals: 'MicCommentBlock "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintEnvironment [
	| micEnvironment |
	micEnvironment := (parser parse: factory environmentSample) children first.
	self assert: (micEnvironment accept: visitor) equals: 'MicEnvironmentBlock parameters:value=aFoo&label=42 "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintHeader [
| micHeader |
	micHeader := (parser parse: factory headerLevel3Sample) children first.
	self assert: (micHeader accept: visitor) equals: 'MicHeaderBlock level:3 "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintHorizontalLine [
	| micHorizontalLine |
	micHorizontalLine := (parser parse: factory horizontalLineSample) children first.
	self assert: (micHorizontalLine accept: visitor) equals: 'MicHorizontalLineBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintListItem [
	| micListItem |
	micListItem := (parser parse: factory listMultiSample) children first children first.
	self assert: (micListItem accept: visitor) equals: 'MicListItemBlock "1"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintMath [
	| micMath |
	micMath := (parser parse: factory mathParametersSample) children first.
	self assert: (micMath  accept: visitor) equals: 'MicMathBlock parameters:label=42 "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintMetaData [
	| micMetaData |
	micMetaData := (parser parse: factory metaDataSample) children first.
	self assert: (micMetaData accept: visitor) equals: 'MicMetaDataBlock parameters: ""author": "Foo""'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicAnchorReferenceBlock [
	| micAnchorReference |
	micAnchorReference := (parser parse: factory anchorReferenceSample) children first children first.
	self assert: (micAnchorReference accept: visitor) equals: 'MicAnchorReferenceBlock "Foo"'.


]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintMicAnnotated [
	| micAnnotated |
	micAnnotated := (parser parse: factory annotatedSample) children first.
	self assert: (micAnnotated accept: visitor) equals: 'MicAnnotatedBlock'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicAnnotationBlock [
	| micAnnotation |
	micAnnotation := (parser parse: factory annotationSample) children first children second.
	self assert: (micAnnotation accept: visitor) equals: 'MicAnnotationBlock "Foo | value=aFoo&label=42"'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicBoldFormatBlock [
	| micBold |
	micBold := (parser parse: factory boldFormatSample) children first children first.
	self assert: (micBold accept: visitor) equals: 'MicBoldFormatBlock "Foo"'

]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicFigureBlock [
	| micFigure |
	micFigure := (parser parse: factory figureSample) children first children first.
	self assert: (micFigure accept: visitor) equals: 'MicFigureBlock parameters:label=figureTest&size=80 url:/anUrl "Foo"'

]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicItalicFormatBlock [
	| micItalic |
	micItalic := (parser parse: factory italicFormatSample) children first children first.
	self assert: (micItalic accept: visitor) equals: 'MicItalicFormatBlock "Foo"'

]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicLinkBlock [
	| micLink |
	micLink := (parser parse: factory linkSample) children first children first.
	self assert: (micLink accept: visitor) equals: 'MicLinkBlock url:/anUrl "Foo"'

]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicMathInlineBlock [
	| micMathInline |
	micMathInline := (parser parse: factory mathInlineSample) children first children first.
	self assert: (micMathInline accept: visitor) equals: 'MicMathInlineBlock "V_i = C_0 - C_3"'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicMonospaceFormatBlock [
	| micMonospace |
	micMonospace := (parser parse: factory monospaceFormatSample) children first children first.
	self assert: (micMonospace accept: visitor) equals: 'MicMonospaceFormatBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicRawBlock [
	| micRaw |
	micRaw := (parser parse: factory rawFormatSample) children first children second.
	self assert: (micRaw accept: visitor) equals: 'MicRawBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicStrikeFormatBlock [
	| micStrike |
	micStrike := (parser parse: factory strikethroughFormatSample) children first children first.
	self assert: (micStrike accept: visitor) equals: 'MicStrikeFormatBlock "Foo"'
]

{ #category : #'tests-inline block' }
MicTextualMicrodownExporterTest >> testPrintMicTextBlock [
	| micText |
	micText := (parser parse: factory headerLevel3Sample) children first children first.
	self assert: (micText accept: visitor) equals: 'MicTextBlock "Foo"'.

]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintOrderedList [
	| micOrderedList |
	micOrderedList := (parser parse: factory orderedListSample) children first.
	self assert: (micOrderedList accept: visitor) equals: 'MicOrderedListBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintParagraph [
	| micParagraph |
	micParagraph := (parser parse: factory paragraphSample) children first.
	self assert: (micParagraph accept: visitor) equals: 'MicParagraphBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintQuote [
	| micQuote |
	micQuote := (parser parse: factory quoteSample) children first.
	self assert: (micQuote accept: visitor) equals: 'MicQuoteBlock "Foo"'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintRoot [
	| micRoot |
	micRoot := (parser parse: factory headerLevel3Sample).
	self assert: (micRoot accept: visitor) equals: 'MicRootBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintTable [
	| micTable |
	self skip.
	self flag: #fixMe.
	"to fix when MicTable will be fix"
	micTable := (parser parse: factory tableSample).
	self assert: (micTable accept: visitor) equals: 'MicTableBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> testPrintUnorderedList [
	| micUnorderedList |
	micUnorderedList := (parser parse: factory unorderedListSample) children first.
	self assert: (micUnorderedList accept: visitor) equals: 'MicUnorderedListBlock'
]

{ #category : #'tests-block' }
MicTextualMicrodownExporterTest >> verifyObtain: aString [
	| micElement |
	micElement := (parser parse: aString).
	self assert: (visitor visit: micElement) equals: aString
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> visitor [

	^ visitor
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> visitor: anObject [

	visitor := anObject
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> visitorClass [

	^ visitorClass
]

{ #category : #accessing }
MicTextualMicrodownExporterTest >> visitorClass: anObject [

	visitorClass := anObject
]
