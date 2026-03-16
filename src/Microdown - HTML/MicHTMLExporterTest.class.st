Class {
	#name : 'MicHTMLExporterTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'parser',
		'writer',
		'factory',
		'newLine'
	],
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'tests - list' }
MicHTMLExporterTest >> orderedListString [

^  '
Here is a list:
1. item 1
2. item 2
3. item 3
'
]

{ #category : 'utils' }
MicHTMLExporterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	self assert: (writer visit: mic) contents equals: aResultingString
]

{ #category : 'running' }
MicHTMLExporterTest >> setUp [
	super setUp.
	parser := MicroDownParser new.
	writer := MicHTMLWriter new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : 'tests' }
MicHTMLExporterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: writer usedNewLine , '<h1>Foo</h1>'
	
]

{ #category : 'tests - list' }
MicHTMLExporterTest >> testOrderedList [

	self 
		parse: self orderedListString 
		andCheckWeGet: 

newLine , '<p>Here is a list:</p>' , newLine , newLine , '<ol>' , newLine , '<li>item 1</li>' , newLine , '<li>item 2</li>' , newLine , '<li>item 3</li>' , newLine , '</ol>'
]

{ #category : 'tests - list' }
MicHTMLExporterTest >> testOrderedListIsRecognized [

	| doc |
	doc := Microdown parse: self orderedListString.
	self assert: doc children second class equals: MicOrderedListBlock 
]

{ #category : 'tests - list' }
MicHTMLExporterTest >> testUnorderedList [
	
	self 
		parse: factory unorderedListWithTwoItemsSample 
		andCheckWeGet: newLine ,
'<ul>', newLine ,
'<li>Foo</li>', newLine ,
'<li>Bar</li>', newLine ,
'</ul>'
]
