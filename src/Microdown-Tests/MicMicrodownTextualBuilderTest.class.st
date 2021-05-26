"
A MicMicrodownTextualBuilderTest is a test class for testing the behavior of MicMicrodownTextualBuilder
"
Class {
	#name : #MicMicrodownTextualBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'parser',
		'builder'
	],
	#category : #'Microdown-Tests-Builder'
}

{ #category : #'tests-codeblock' }
MicMicrodownTextualBuilderTest >> exampleTextMultipleLines [
	^ 'Hello
Pharo'
]

{ #category : #initialization }
MicMicrodownTextualBuilderTest >> setUp [
	super setUp.
	factory := MicMicroDownSnippetFactory new.
	parser := MicroDownParser new.
	builder := parser builder
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testAnchor [

	self assert: (builder anchor: 'Anchor') contents equals: parser anchorMarkup, 'Anchor'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testAnchorReference [

	self assert: (builder anchorReference: 'AnchorReference') contents equals: parser class anchorReferenceOpenerMarkup, 'AnchorReference', parser class anchorReferenceCloserMarkup
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testBold [

	self assert: (builder bold: 'Bold') contents equals: '**Bold**'
]

{ #category : #'tests-codeblock' }
MicMicrodownTextualBuilderTest >> testCodeBlockCaptionContainsMonospace [

	"```language2=Pharo&caption=`Color` is cool
	Hello
	Pharo
	```"

	| mictext |
	mictext := builder
		           codeblock: self exampleTextMultipleLines
		           firstLineAssociations: { 
				           ('language2' -> 'Pharo').
				           ('caption' -> '`Color` is cool') };
		           contents.
	self 
		assert: mictext 
		equals: 
'```language2=Pharo&caption=`Color` is cool
', self exampleTextMultipleLines, 

'
```
'

]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testComment [

	self assert: (builder comment: 'Comment') contents equals: parser commentedLineMarkup, ' Comment'
]

{ #category : #'tests - header' }
MicMicrodownTextualBuilderTest >> testHeaderWithItalic [

	self 
		assert: (builder 
							header: [ :b | b text: 'Hello '.
											 b italic: 'Pharo'.
											 b text: ' is cool']  withLevel: 1;				
							contents) contents 
		equals: parser headerMarkup , ' Hello _Pharo_ is cool
'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testHorizontalLine [

	self assert: (builder horizontalLine) contents equals: parser horizontalLineMarkup, String cr
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testItalic [

	self assert: (builder italic: 'Italic') contents equals: '_Italic_'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testMathInline [

	self assert: (builder mathInline: 'x = 2 + y') contents equals: '$x = 2 + y$'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testMonospace [

	self assert: (builder monospace: 'Monospace') contents equals: '`Monospace`'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testParagraph [

	self assert: (builder paragraph: [:v | builder text: 'aParagraph']) contents equals: 'aParagraph', String cr
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testQuote [

	self assert: (builder quoteBlock: 'aQuote') contents equals: parser class preformattedMarkup, ' aQuote'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testRawFormat [

	self assert: (builder rawFormat: 'aRawFormat') contents equals: MicRawOpenerDelimiter markup, 'aRawFormat', MicRawCloserDelimiter markup
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testStrike [

	self assert: (builder strike: 'Strike') contents equals: '~Strike~'
]
