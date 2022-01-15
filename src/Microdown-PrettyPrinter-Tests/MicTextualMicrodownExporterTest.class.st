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
	factory := MicMicrodownSnippetFactory new.
	visitor := self visitorClass new.
	parser := MicroDownParser new
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnchor [
	| micAnchor |
	micAnchor := parser parse: factory anchorSample.
	self assert: (visitor visit: micAnchor) first asString equals: parser anchorMarkup
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnchorAutomatic [

	self verifyObtain: factory anchorSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnchorReference [
	"Pay attention an anchor reference is inside a paragraph and a paragraph emits 
	a newline "
	| micElement |
	micElement := parser parse: factory anchorReferenceSample.
	self assert: (visitor visit: micElement) equals: '
*@Foo@*
'.
	self flag: #newline.
	
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnnotated [
	self verifyObtain: factory annotatedSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnnotation [
	self verifyObtain: factory annotationSample
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testCodeBlock [ 
	self verifyObtain: factory blockWithParametersSample, String cr
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testCodeBlockNewLine [
	
	| mic |
	mic := parser parse: '```
	this is a codeblock
```'.
	self assert: (mic accept: visitor) contents equals: '
```
 this is a codeblock
```
'
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testCodeBlockWithCaption [
	self verifyObtain: factory blockWithParametersWithCaptionSample, String cr
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testComment [
	self verifyObtain: factory commentSample
]

{ #category : #'tests - environment' }
MicTextualMicrodownExporterTest >> testEnvironment [
	self verifyObtain: factory environmentSample
]

{ #category : #'tests - environment' }
MicTextualMicrodownExporterTest >> testEnvironmentWithInnerBlock [

	self skip.
	"The parsing of environment is plain wrong. It should recursively parse subelements"
	
	self verifyObtain: factory environmentWithInnerBlockSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigure [
	self verifyObtain: factory figureSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureNewLine [
	
	| mic |
	"there is two newLine because a figure is a inlineblock which is in a paragraph"
	mic := parser parse: '![Pharo is is cool](http://pharo.org/)'.
	self assert: (mic accept: visitor) contents equals: '

![Pharo is is cool](http://pharo.org/)
'
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithBold [
	self verifyObtain: factory figureBoldSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithItalic [
	self verifyObtain: factory figureItalicSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithMicroDownMarkup [

	| mic |
	"there is two newLine because a figure is a inlineblock which is in a paragraph"
	mic := parser parse: '![Pharo is \~is c\**ool](http://pharo.org/)'.
	self assert: (mic accept: visitor) contents equals: '

![Pharo is \~is c\**ool](http://pharo.org/)
'
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithMonospace [
	self verifyObtain: factory figureMonospaceSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithNested [
	self verifyObtain: factory figureNestedSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithStrike [
	self verifyObtain: factory figureStrikeSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFileFigure [
	self verifyObtain: factory fileFigureSample
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testHeaderNewLine [

	| mic |
	mic := parser parse: '# header 1
# header 2'.
	self assert: (mic accept: visitor) contents equals: '
# header 1

# header 2
'
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testHeaderWithBold [
	
	self verifyObtain: factory headerWithFormatSampleWithNewLine
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testHeaderWithMicroDownMarkup [

	| mic |
	mic := parser parse: '# header\~ 1
'.
	self assert: (mic accept: visitor) contents equals: '
# header\~ 1
'
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testHeaderWithNestedFormatSampleWithNewLine [
	
	self verifyObtain: factory headerWithNestedFormatSampleWithNewLine.

]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testHorizontalLine [
	self verifyObtain: factory horizontalLineSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testInputfile [
	self verifyObtain: factory inputfileSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLink [
	self verifyObtain: factory linkSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithBold [
	self verifyObtain: factory linkBoldSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithItalic [
	self verifyObtain: factory linkItalicSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithMicroDownMarkup [

	| mic |
	"there is two newLine because a figure is a inlineblock which is in a paragraph"
	mic := parser parse: '[Pharo is \~is c\**ool](http://pharo.org/)'.
	self assert: (mic accept: visitor) contents equals: '
[Pharo is \~is c\**ool](http://pharo.org/)
'
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithMonospace [
	self verifyObtain: factory linkMonospaceSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithNested [
	
	self verifyObtain: factory linkNestedSample
]

{ #category : #'tests - link' }
MicTextualMicrodownExporterTest >> testLinkWithStrike [
	self verifyObtain: factory linkStrikeSample
]

{ #category : #'tests - math' }
MicTextualMicrodownExporterTest >> testMathBlock [ 
	self verifyObtain: factory mathParametersSample, String cr
]

{ #category : #'tests - math' }
MicTextualMicrodownExporterTest >> testMathBlockWithCaption [
	self verifyObtain: factory mathParametersWithCaptionSample, String cr
]

{ #category : #'tests - math' }
MicTextualMicrodownExporterTest >> testMathInline [
	self verifyObtain: factory mathInlineSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testMetaData [
	self skip.
	self flag: #fixme.
	"the builder wait a collection of associotion or a dictionnary but a metaData has not that"

	self verifyObtain: factory metaDataSample
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testNestedHeader [

	| header res |
	header := parser parse: factory headerWithNestedFormatSampleWithNewLine.
	res := visitor visit: header.
	self assert: (res at: res size -1)  asString equals: parser italicMarkup.
	self assert: (res copyFrom: res size -3 to: res size - 2) equals: parser boldMarkup
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedList [

	self verifyObtain: factory orderedListWithTwoItemsSample 
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListNewLine [

	| mic |
	mic := parser parse: '1. item1
1. item2'.
	self assert: (mic accept: visitor) contents equals: '
1. item1
1. item2
'
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListWithBold [

	self verifyObtain: factory orderedListWithTwoItemsBoldSample  
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListWithItalic [

	self verifyObtain: factory orderedListWithTwoItemsItalicSample  
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListWithMonospace [

	self verifyObtain: factory orderedListWithTwoItemsMonospaceSample  
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListWithNested [

	self verifyObtain: factory orderedListWithTwoItemsBoldFirstSample  
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testOrderedListWithStrike [

	self verifyObtain: factory orderedListWithTwoItemsStrikeSample  
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraph [
	self verifyObtain: factory paragraphSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphNewLine [
	
	| mic |
	mic := parser parse: 'blabla1'.
	self assert: (mic accept: visitor) contents equals: '
blabla1
'
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithBold [
	self verifyObtain: factory paragraphBoldSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithItalic [
	self verifyObtain: factory paragraphItalicSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithMicroDownMarkup [

	| mic |
	mic := parser parse: 'blab\~l\**a*1'.
	self assert: (mic accept: visitor) contents equals: '
blab\~l\**a*1
'
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithMonospace [
	self verifyObtain: factory paragraphMonospaceSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithNested [
	self verifyObtain: factory paragraphNestedSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithStrike [
	self verifyObtain: factory paragraphStrikeSample
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testPlainHeader [

	self verifyObtain: factory headerLevel3SampleWithNewLine 
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testQuote [
	self verifyObtain: factory quoteSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testRawFormat [
	self verifyObtain: factory rawFormatSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testRoot [
	self verifyObtain: factory rootSample
]

{ #category : #tests }
MicTextualMicrodownExporterTest >> testSimpleTable [
	self verifyObtain: factory simpleTable
]

{ #category : #tests }
MicTextualMicrodownExporterTest >> testSimpleTableWithFormatting [
	self verifyObtain: factory simpleTableFormat
]

{ #category : #tests }
MicTextualMicrodownExporterTest >> testSimpleTableWithFormattingWithShortRow [
	self verifyObtain: factory simpleTableShortRow
]

{ #category : #tests }
MicTextualMicrodownExporterTest >> testSimpleTableWithFormattingWithSomeElements [
	self verifyObtain: factory simpleTableMoreFormat
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedList [

	self verifyObtain: factory unorderedListWithTwoItemsSample
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListNestedNewLine [

	| mic |
	mic := parser parse: '- item 1
  - item 1.1
  - item 1.2
- item 2'.
	self assert: (mic accept: visitor) contents equals: '
- item 1
  - item 1.1
  - item 1.2
- item 2
'
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListNestedWithOrderedNewLine [

	| mic |
	mic := parser parse: '- item 1
  1. item 1.1
  1. item 1.2
- item 2'.
	self assert: (mic accept: visitor) contents equals: '
- item 1
  1. item 1.1
  1. item 1.2
- item 2
'
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListNewLine [

	| mic |
	mic := parser parse: '- item1
- item2'.
	self assert: (mic accept: visitor) contents equals: '
- item1
- item2
'
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListWithBold [

	self verifyObtain: factory unorderedListWithTwoItemsBoldSample
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListWithItalic [

	self verifyObtain: factory unorderedListWithTwoItemsItalicSample
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListWithMonospace [

	self verifyObtain: factory unorderedListWithTwoItemsMonospaceSample
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListWithNested [

	self verifyObtain: factory unorderedListWithTwoItemsNestedSample
]

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedListWithStrike [

	self verifyObtain: factory unorderedListWithTwoItemsStrikeSample
]

{ #category : #utilities }
MicTextualMicrodownExporterTest >> verifyObtain: aString [
	| micElement |
	micElement := parser parse: aString.
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
