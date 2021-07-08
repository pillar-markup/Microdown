Class {
	#name : #MicHTMLWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'footnoteID',
		'noteDictionary',
		'writer',
		'parser',
		'factory'
	],
	#category : #'Microdown - HTML'
}

{ #category : #running }
MicHTMLWriterTest >> setUp [
	super setUp.
	writer := MicHTMLWriter new.
	parser := MicroDownParser new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : #tests }
MicHTMLWriterTest >> testBold [
	| mic |
	mic := parser parse: factory boldFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<strong>Foo</strong>
</p>'
]

{ #category : #tests }
MicHTMLWriterTest >> testHeaderLevel3HTML [
	| mic |
	mic := parser parse: factory headerLevel3Sample.
	self assert: (writer start: mic) contents equals: '<h3>Foo</h3>
'
]

{ #category : #tests }
MicHTMLWriterTest >> testParagraph [
	| mic |
	mic := parser parse: factory paragraphSample.
	self assert: (writer start: mic) contents equals: '<p>
Foo
</p>'
]

{ #category : #tests }
MicHTMLWriterTest >> testParagraphWithBold [
	| mic |
	mic := parser parse: factory paragraphBoldSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <strong>paragraph</strong>
</p>'
]
