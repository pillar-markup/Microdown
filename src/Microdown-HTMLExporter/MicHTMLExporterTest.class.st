Class {
	#name : #MicHTMLExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'writer',
		'factory'
	],
	#category : #'Microdown-HTMLExporter'
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

{ #category : #tests }
MicHTMLExporterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: writer usedNewLine ,'<p>Foo</p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testUnorderedList [

	self parse: factory unorderedListWithTwoItemsSample andCheckWeGet: '
<ul>
<li>Foo</li>
<li>Bar</li>
</ul>'
]
