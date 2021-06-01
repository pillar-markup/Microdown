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
	self verifyObtain: factory anchorReferenceSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnnotated [
	self verifyObtain: factory annotatedSample
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testCodeBlock [ 
	self verifyObtain: factory scriptParametersSample, String cr
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testCodeBlockWithCaption [
	self verifyObtain: factory scriptParametersWithCaptionSample, String cr
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testComment [
	self verifyObtain: factory commentSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testEnvironment [
	self verifyObtain: factory environmentSample
]

{ #category : #'tests - environment' }
MicTextualMicrodownExporterTest >> testEnvironmentWithInnerBlock [
	self verifyObtain: factory environmentWithInnerBlockSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigure [
	self verifyObtain: factory figureSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigureWithBold [
	self verifyObtain: factory figureBoldSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigureWithItalic [
	self verifyObtain: factory figureItalicSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigureWithMonospace [
	self verifyObtain: factory figureMonospaceSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigureWithNested [
	self verifyObtain: factory figureNestedSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigureWithStrike [
	self verifyObtain: factory figureStrikeSample
]

{ #category : #'tests-header' }
MicTextualMicrodownExporterTest >> testHeaderWithBold [
	
	self verifyObtain: factory headerWithFormatSampleWithNewLine
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
MicTextualMicrodownExporterTest >> testLink [
	self verifyObtain: factory linkSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testLinkWithBold [
	self verifyObtain: factory linkBoldSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testLinkWithItalic [
	self verifyObtain: factory linkItalicSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testLinkWithMonospace [
	self verifyObtain: factory linkMonospaceSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testLinkWithNested [
	
	self skip.
	self flag: #fixme.
	"the link have three children **, italicBlock, boldBlock for [**_Foo_**]"
	self verifyObtain: factory linkNestedSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testLinkWithStrike [
	self verifyObtain: factory linkStrikeSample
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testMathBlock [ 
	self verifyObtain: factory mathParametersSample, String cr
]

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testMathBlockWithCaption [
	self verifyObtain: factory mathParametersWithCaptionSample, String cr
]

{ #category : #'tests-anchor' }
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

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedList [

	self verifyObtain: factory orderedListWithTwoItemsSample 
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedListWithBold [

	self verifyObtain: factory orderedListWithTwoItemsBoldSample  
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedListWithItalic [

	self verifyObtain: factory orderedListWithTwoItemsItalicSample  
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedListWithMonospace [

	self verifyObtain: factory orderedListWithTwoItemsMonospaceSample  
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedListWithNested [

	self verifyObtain: factory orderedListWithTwoItemsNestedSample  
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testOrderedListWithStrike [

	self verifyObtain: factory orderedListWithTwoItemsStrikeSample  
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testParagraph [
	self verifyObtain: factory paragraphSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testParagraphWithBold [
	self verifyObtain: factory paragraphBoldSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testParagraphWithItalic [
	self verifyObtain: factory paragraphItalicSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testParagraphWithMonospace [
	self verifyObtain: factory paragraphMonospaceSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testParagraphWithNested [
	self verifyObtain: factory paragraphNestedSample
]

{ #category : #'tests-anchor' }
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

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedList [

	self verifyObtain: factory unorderedListWithTwoItemsSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedListWithBold [

	self verifyObtain: factory unorderedListWithTwoItemsBoldSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedListWithItalic [

	self verifyObtain: factory unorderedListWithTwoItemsItalicSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedListWithMonospace [

	self verifyObtain: factory unorderedListWithTwoItemsMonospaceSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedListWithNested [

	self verifyObtain: factory unorderedListWithTwoItemsNestedSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testUnorderedListWithStrike [

	self verifyObtain: factory unorderedListWithTwoItemsStrikeSample
]

{ #category : #utils }
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
