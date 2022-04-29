"
A MicHTMLWriterTest is a test class for testing the behavior of MicHTMLWriter
"
Class {
	#name : #MicHTMLVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'micHTMLWriter'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicHTMLVisitorTest >> generateFilesystemExample [

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
MicHTMLVisitorTest >> setUp [
	super setUp.
	micHTMLWriter := MicHTMLVisitor new.
	filesystem := FileSystem memory.
	self generateFilesystemExample.
]

{ #category : #tests }
MicHTMLVisitorTest >> testCanvasClass [

	self assert: micHTMLWriter canvasClass equals: MicHTMLCanvas
]

{ #category : #tests }
MicHTMLVisitorTest >> testContents [ 

	self assert: micHTMLWriter contents equals: String empty.
	micHTMLWriter visitItalic: (MicItalicFormatBlock new textElement: (MicTextBlock new substring: 'test')).
	self assert: micHTMLWriter contents equals: '<i>test</i>'.
]

{ #category : #tests }
MicHTMLVisitorTest >> testConvertMicFile [
	
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
MicHTMLVisitorTest >> testConvertMicString [

	| result |
	
	result := micHTMLWriter convertMicString: MicMicrodownSnippetFactory buildDocument.
	
	self assert: (result isKindOf: String).
	self assert: result notEmpty.

]

{ #category : #tests }
MicHTMLVisitorTest >> testConvertMicStringToDoc [

	| expectedHtmlDoc |
	
	expectedHtmlDoc := Microdown asHTMLString: MicMicrodownSnippetFactory buildDocument.
	self 
		assert: (expectedHtmlDoc isKindOf: String)
		description: 'It tests that result is a String object'.
	self 
		deny: expectedHtmlDoc isEmpty 
		description: 'It test that result is not empty'.
	self
		assert: (expectedHtmlDoc trimBoth beginsWith: '<p>')
		description: 'It test that result contains the expected document tag'
]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateAnchorWithId [

	self assert: micHTMLWriter contents equals: String empty.
	micHTMLWriter createAnchorWithId: 'id1'.
	self assert: micHTMLWriter contents equals: '<a id="id1"></a>'.
]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateAnchorWithLink [

	| result |
	self assert: micHTMLWriter contents equals: String empty.
	result := micHTMLWriter convertMicString: '[Pharo Website](http://pharo.org target=blank&rel=bookmark)'.
	self assert: result trimBoth equals: '<p><a href="http://pharo.org/" rel="bookmark" target="blank">Pharo Website</a></p>'.
]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateAnnotationCompound [

	| result |
	
	result := micHTMLWriter convertMicString: '# This is a title
!!LabelOfAnnotatedBlock Body of annotated block

this is another string'.
	self assert: result trimBoth equals: '<h1>This is a title</h1>
<section class="annotation"><label>LabelOfAnnotatedBlock</label><div>Body of annotated block</div></section>
<p>this is another string</p>'.
]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateAnnotationSimple [

	| result |
	self assert: micHTMLWriter contents equals: String empty.
	
	result := micHTMLWriter convertMicString: '!!LabelOfAnnotatedBlock Body of annotated block'.
	self assert: result trimBoth equals: '<section class="annotation"><label>LabelOfAnnotatedBlock</label><div>Body of annotated block</div></section>'.	

]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateCitation [

	| result |
	self assert: micHTMLWriter contents equals: String empty.
	
	result := micHTMLWriter convertMicString: '{!citation|ref=Duca99a!}'.
	self assert: result trimBoth equals: '<p><cite>Duca99a</cite></p>'.	

]

{ #category : #tests }
MicHTMLVisitorTest >> testCreateItalic [

	| result |
	self assert: micHTMLWriter contents equals: String empty.
	
	result := micHTMLWriter convertMicString: '_Text with italic_'.
	self assert: result trimBoth equals: '<p><i>Text with italic</i></p>'.	

]
