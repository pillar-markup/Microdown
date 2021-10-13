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
MicHTMLExporterTest >> testParagraphNestedSample [

	self parse: factory paragraphNestedSample andCheckWeGet:  '
<p>this is a <strong><em>paragraph</em></strong></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphWithBold [

	self parse: factory paragraphBoldSample andCheckWeGet:  '
<p>this is a <strong>paragraph</strong></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet:  '
<p>this is a <em>paragraph</em></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphWithMonospace [

	self parse: factory paragraphMonospaceSample andCheckWeGet:  '
<p>this is a <code>paragraph</code></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testUnorderedList [

	self parse: factory unorderedListWithTwoItemsSample andCheckWeGet: '
<ul>
<li>Foo</li>
<li>Bar</li>
</ul>'
]
