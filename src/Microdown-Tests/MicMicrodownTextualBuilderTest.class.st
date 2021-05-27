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
MicMicrodownTextualBuilderTest >> exampleMathTextMultipleLines [
	^ 'y = 3
x = 2 + y'
]

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
MicMicrodownTextualBuilderTest >> testAnnotated [

	self assert: (builder annotated: 'anAnnotation' paragraph:  [:v | builder text: 'anAnnotatedParagraph']) contents equals: '!!anAnnotation anAnnotatedParagraph', String cr
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

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testExternalLink [

	self assert: (builder externalLink: 'anUrl' withDescription: 'aDescription' ) contents equals: '[aDescription](anUrl)'
]

{ #category : #'tests - header' }
MicMicrodownTextualBuilderTest >> testFigureWithBold [

	self 
		assert: (builder 
							figure: 'anUrl' withDescription: [:b | b text: 'it is a'.
																			  b bold: 'beatifull'.
																			  b text: 'figure'];				
							contents) contents 
		equals: '![it is a**beatifull**figure](anUrl)'
]

{ #category : #'tests - header' }
MicMicrodownTextualBuilderTest >> testFigureWithParameters [
	| descriptionBlock dictionnary |
	descriptionBlock := [:b | b text: 'it is a beatifull figure'].
	dictionnary := {'label'->'aLabel' . 'size'->'80'} asOrderedDictionary.
	self 
		assert: (builder 
							figure: 'anUrl' withDescription: descriptionBlock withParameters:  dictionnary;				
							contents) contents 
		equals: '![it is a beatifull figure](anUrl|label=aLabel&size=80)'
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

{ #category : #'tests-codeblock' }
MicMicrodownTextualBuilderTest >> testMathBlockCaptionContainsMonospace [

	"```language2=Pharo&caption=`Color` is cool
	Hello
	Pharo
	```"

	| mictext |
	mictext := builder
		           mathblock: self exampleMathTextMultipleLines
		           firstLineAssociations: { 
				           ('label' -> 'Math').
				           ('caption' -> '`Math` is cool') };
		           contents.
	self 
		assert: mictext 
		equals: 
'&label=Math&caption=`Math` is cool
', self exampleMathTextMultipleLines, 

'
&
'

]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testMathInline [

	self assert: (builder mathInline: 'x = 2 + y') contents equals: '$x = 2 + y$'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testMetaData [

	self 
		assert: (builder metaDataFromAssociations: {'label'->'aLabel' . 'size'->'142'}) contents 
		equals: parser metaDataOpeningBlockMarkup , String cr ,'"label" : "aLabel" , "size" : "142"', String cr , parser metaDataClosingBlockMarkup
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testMonospace [

	self assert: (builder monospace: 'Monospace') contents equals: '`Monospace`'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testOrderedList [

	self 
		assert: (builder orderedListDuring: [ :b | {'item1' . 'item2' . 'item3' } do: [ :each | b orderedItem: [:bu | bu text: each] ] ]) contents
		equals: '1. item1
1. item2
1. item3
'
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

{ #category : #'tests - header' }
MicMicrodownTextualBuilderTest >> testRoot [
	| descriptionBlock dictionnary |
	descriptionBlock := [:b | b text: 'it is a beatifull figure'].
	dictionnary := {'label'->'aLabel' . 'size'->'80'} asOrderedDictionary.
	self 
		assert: (builder 
							root: [ :b | b paragraph: [:v | builder text: 'aParagraph'].
											 b figure: 'anUrl' withDescription: descriptionBlock withParameters:  dictionnary ] ;				
							contents) contents 
		equals: 'aParagraph
![it is a beatifull figure](anUrl|label=aLabel&size=80)'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testStrike [

	self assert: (builder strike: 'Strike') contents equals: '~Strike~'
]

{ #category : #'tests - anchor' }
MicMicrodownTextualBuilderTest >> testUnorderedList [

	self 
		assert: (builder unorderedListDuring: [ :b | {'item1' . 'item2' . 'item3' } do: [ :each | b item: [:bu | bu text: each] ] ]) contents
		equals: '- item1
- item2
- item3
'
]
