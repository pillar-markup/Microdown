Class {
	#name : #MicHTMLExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'writer',
		'factory'
	],
	#category : #'Microdown - HTML'
}

{ #category : #utils }
MicHTMLExporterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	self assert: (writer visit: mic) contents equals: aResultingString
]

{ #category : #running }
MicHTMLExporterTest >> setUp [
	super setUp.
	parser := MicroDownParser new.
	writer := MicHTMLWriter new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: writer usedNewLine , '<h1>Foo</h1>'
	
]
