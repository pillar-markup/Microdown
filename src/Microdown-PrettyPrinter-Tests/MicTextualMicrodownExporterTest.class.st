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
	self verifyObtain: factory scriptWithSpacedParametersSample, String cr
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testComment [
	self verifyObtain: factory commentSample
]

{ #category : #'tests-anchor' }
MicTextualMicrodownExporterTest >> testFigure [
	self verifyObtain: factory figureSample
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

{ #category : #'tests-codeblock' }
MicTextualMicrodownExporterTest >> testMathBlock [ 
	self verifyObtain: factory mathParametersSample, String cr
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
