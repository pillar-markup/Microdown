Class {
	#name : #MicFileHTMLWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'converter'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicFileHTMLWriterTest >> generateFilesystemExample [

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
MicFileHTMLWriterTest >> setUp [
	super setUp.
	converter := MicFileHTMLWriter new.
	filesystem := FileSystem memory.
	self generateFilesystemExample.
]

{ #category : #tests }
MicFileHTMLWriterTest >> testConvertFile [
	
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
