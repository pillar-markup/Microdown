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
