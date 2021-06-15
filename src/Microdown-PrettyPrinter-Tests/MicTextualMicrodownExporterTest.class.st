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

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testAnnotation [
	self verifyObtain: factory annotationSample
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
MicTextualMicrodownExporterTest >> testFigureWithBold [
	self verifyObtain: factory figureBoldSample
]

{ #category : #'tests - figure' }
MicTextualMicrodownExporterTest >> testFigureWithItalic [
	self verifyObtain: factory figureItalicSample
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

	self verifyObtain: factory orderedListWithTwoItemsNestedSample  
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
MicTextualMicrodownExporterTest >> testParagraphWithBold [
	self verifyObtain: factory paragraphBoldSample
]

{ #category : #'tests - paragraph' }
MicTextualMicrodownExporterTest >> testParagraphWithItalic [
	self verifyObtain: factory paragraphItalicSample
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

{ #category : #'tests - list' }
MicTextualMicrodownExporterTest >> testUnorderedList [

	self verifyObtain: factory unorderedListWithTwoItemsSample
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
