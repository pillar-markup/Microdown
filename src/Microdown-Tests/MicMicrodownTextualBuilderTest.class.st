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
MicMicrodownTextualBuilderTest >> testParagraph [

	self assert: (builder paragraph: ['This is **_a Paragraph_**']) contents equals: 'This is **_a Paragraph_**', String cr
]
