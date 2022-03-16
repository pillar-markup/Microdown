"
A MicHTMLWriterTest is a test class for testing the behavior of MicHTMLWriter
"
Class {
	#name : #MicHTMLWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'micHTMLWriter'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicHTMLWriterTest >> generateFilesystemExample [

	| file |
	file := filesystem workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
@sec1

Pharo is cool

```
	this is a code blu blu
```
' ].
	file := filesystem workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '## Bar
@sec2
Pharo is **cool**

```
	this is a code 2
```
' ]
]

{ #category : #running }
MicHTMLWriterTest >> setUp [
	super setUp.
	micHTMLWriter := MicHTMLWriter new.
	filesystem := FileSystem memory.
	self generateFilesystemExample.
]

{ #category : #tests }
MicHTMLWriterTest >> testCanvasClass [

	self assert: micHTMLWriter canvasClass equals: MicHTMLCanvas
]

{ #category : #tests }
MicHTMLWriterTest >> testContents [ 

	self assert: micHTMLWriter contents equals: String empty.
	micHTMLWriter visitItalic: (MicItalicFormatBlock new textElement: (MicTextBlock new substring: 'test')).
	self assert: micHTMLWriter contents equals: '<em>test</em>'.
]

{ #category : #tests }
MicHTMLWriterTest >> testConvertMicFile [
	
	micHTMLWriter convertMicFile: (filesystem / 'anExample1.md') asFileReference.
	
	self assert: (filesystem / 'anExample1.html') asFileReference exists.
	self 
		assert: (filesystem / 'anExample1.html') asFileReference contents 
		equals: '
<h1>Foo</h1><a id="sec1"></a>
<p>Pharo is cool</p>
<pre><code> this is a code blu blu</code></pre>
'.
]

{ #category : #tests }
MicHTMLWriterTest >> testConvertMicString [

	| result |
	
	result := micHTMLWriter convertMicString: MicMicrodownSnippetFactory buildDocument.
	
	self assert: (result isKindOf: String).
	self assert: result notEmpty.

]

{ #category : #tests }
MicHTMLWriterTest >> testConvertMicStringToDoc [

	| expectedHtmlDoc |
	
	expectedHtmlDoc := Microdown asHTMLDocument: MicMicrodownSnippetFactory buildDocument.
	self 
		assert: (expectedHtmlDoc isKindOf: String)
		description: 'It tests that result is a String object'.
	self 
		deny: expectedHtmlDoc isEmpty 
		description: 'It test that result is not empty'.
	self
		assert: (expectedHtmlDoc beginsWith: MicHTMLDocBuilder documentType)
		description: 'It test that result contain the expected document type tag'
]

{ #category : #tests }
MicHTMLWriterTest >> testCreateAnchorWithId [

	self assert: micHTMLWriter contents equals: String empty.
	micHTMLWriter createAnchorWithId: 'id1'.
	self assert: micHTMLWriter contents equals: '<a id="id1"></a>'.
]

{ #category : #tests }
MicHTMLWriterTest >> testCreateAnchorWithLink [

	| result |
	self assert: micHTMLWriter contents equals: String empty.
	result := micHTMLWriter convertMicString: '[Pharo Website](http://pharo.org target=blank&rel=bookmark)'.
	self assert: result trimBoth equals: '<p><a href="http://pharo.org/" rel="bookmark" target="blank">Pharo Website</a></p>'.
]
