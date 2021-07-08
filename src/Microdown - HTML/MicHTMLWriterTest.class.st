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

{ #category : #'tests - formats' }
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

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testItalic [
	| mic |
	mic := parser parse: factory italicFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<em>Foo</em>
</p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testMonospace [
	| mic |
	mic := parser parse: factory monospaceFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<code>Foo</code>
</p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testNested [
	| mic |
	mic := parser parse: factory nestedBoldFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<em><strong>Foo</strong></em>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraph [
	| mic |
	mic := parser parse: factory paragraphSample.
	self assert: (writer start: mic) contents equals: '<p>
Foo
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithBold [
	| mic |
	mic := parser parse: factory paragraphBoldSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <strong>paragraph</strong>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithItalic [
	| mic |
	mic := parser parse: factory paragraphItalicSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <em>paragraph</em>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithMonospace [
	| mic |
	mic := parser parse: factory paragraphMonospaceSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <code>paragraph</code>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithNested [
	| mic |
	mic := parser parse: factory paragraphNestedSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <strong><em>paragraph</em></strong>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithStrike [
	| mic |
	mic := parser parse: factory paragraphStrikeSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <s>paragraph</s>
</p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testStrike [
	| mic |
	mic := parser parse: factory strikethroughFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<s>Foo</s>
</p>'
]
