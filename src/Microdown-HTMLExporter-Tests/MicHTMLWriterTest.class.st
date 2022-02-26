"
A MicHTMLWriterTest is a test class for testing the behavior of MicHTMLWriter
"
Class {
	#name : #MicHTMLWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'converter',
		'filesystem'
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
	converter := MicHTMLWriter new.
	filesystem := FileSystem memory.
	self generateFilesystemExample.
]

{ #category : #test }
MicHTMLWriterTest >> testCanvasClass [

	self assert: converter canvasClass equals: MicHTMLCanvas
]

{ #category : #test }
MicHTMLWriterTest >> testContents [ 

	self assert: converter contents equals: String empty.
	converter visitItalic: (MicItalicFormatBlock new textElement: (MicTextBlock new substring: 'test')).
	self assert: converter contents equals: '<em>test</em>'.
]

{ #category : #test }
MicHTMLWriterTest >> testConvertFile [
	
	converter convertFile: (filesystem / 'anExample1.md') asFileReference.
	
	self assert: (filesystem / 'anExample1.html') asFileReference exists.
	self 
		assert: (filesystem / 'anExample1.html') asFileReference contents 
		equals: '
<h1>Foo</h1><a id="sec1"></a>
<p>Pharo is cool</p>
<pre><code> this is a code blu blu</code></pre>
'.
]

{ #category : #test }
MicHTMLWriterTest >> testCreateAnchorWith [

	self assert: converter contents equals: String empty.
	converter createAnchorWith: 'id1'.
	self assert: converter contents equals: '<a id="id1"></a>'.
]
