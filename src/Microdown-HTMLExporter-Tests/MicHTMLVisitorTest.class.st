"
A MicHTMLWriterTest is a test class for testing the behavior of MicHTMLWriter
"
Class {
	#name : 'MicHTMLVisitorTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'writer',
		'newLine',
		'fileSystem'
	],
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'tests' }
MicHTMLVisitorTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicHTMLVisitor };
		  forSelector: #fileSystem addOptions: { FileSystem };
		  forSelector: #newLine addOptions: { String cr . String lf . String crlf };
		  yourself
]

{ #category : 'accessing' }
MicHTMLVisitorTest >> fileSystem: aFileSystem [
	fileSystem := aFileSystem memory.
]

{ #category : 'running' }
MicHTMLVisitorTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
@sec1

Pharo is cool

```
this is a code blu blu
```
' ].
	file := fileSystem workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '## Bar
@sec2
Pharo is **cool**

```
this is a code 2
```
' ]
]

{ #category : 'accessing' }
MicHTMLVisitorTest >> newLine: aNewLine [
	(aNewLine = String cr) ifTrue:[ writer crAsNewLine ].
	(aNewLine = String lf) ifTrue:[ writer lfAsNewLine ].
	(aNewLine = String crlf) ifTrue:[ writer crlfAsNewLine ].
	newLine := aNewLine
]

{ #category : 'running' }
MicHTMLVisitorTest >> setUp [
	super setUp.
	self generateFilesystemExample.
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCanvasClass [

	self assert: writer canvasClass equals: MicHTMLCanvas
]

{ #category : 'test' }
MicHTMLVisitorTest >> testConfiguration [

	self assert: (writer configuration isKindOf: MicHTMLConfiguration). 
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testContents [

	self assert: writer contents equals: String empty.
	writer visitItalic: (MicItalicFormatBlock new children:
			 { (MicTextBlock new bodystring: 'test') }).
	self assert: writer contents equals: '<i>test</i>'
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testConvertMicFile [

	writer convertMicFile: (fileSystem / 'anExample1.md') asFileReference.

	self assert: (fileSystem / 'anExample1.html') asFileReference exists.
	self
		assert: (fileSystem / 'anExample1.html') asFileReference contents
		equals: newLine , '<h1>Foo</h1><a id="sec1"></a>' , newLine
			, '<p>Pharo is cool</p>' , newLine
			, '<pre><code>this is a code blu blu</code></pre>' , newLine
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testConvertMicString [

	| result |
	
	result := writer convertMicString: MicMicrodownSnippetFactory buildDocument.
	
	self assert: (result isKindOf: String).
	self assert: result notEmpty.

]

{ #category : 'tests' }
MicHTMLVisitorTest >> testConvertMicStringToDoc [

	| expectedHtmlDoc |
	
	expectedHtmlDoc := Microdown asHTMLString: MicMicrodownSnippetFactory buildDocument.
	self 
		assert: (expectedHtmlDoc isKindOf: String)
		description: 'It tests that result is a String object'.
	self 
		deny: expectedHtmlDoc isEmpty 
		description: 'It test that result is not empty'.
		
	"parsedContents := (XMLHTMLParser on: expectedHtmlDoc contents) parseDocument.
	#('code' 'i' 'a' 'pre' 'strike' 'table' 'ul' 'p') do: [ : tag |
		self
			assert: ((parsedContents descendantElementsNamed: tag) elementNames notEmpty)
			description: 'It test that result contains the expected document tag' ]"
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCreateAnchorWithLink [

	| result |
	self assert: writer contents equals: String empty.
	result := writer convertMicString: '[Pharo Website](http://pharo.org target=blank&rel=bookmark)'.
	self assert: result trimBoth equals: '<p><a target="_blank" href="http://pharo.org/" rel="bookmark" target="blank">Pharo Website</a></p>'.
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCreateAnnotationCompound [

	| result |
	
	result := writer convertMicString: '# This is a title
!!LabelOfAnnotatedBlock Body of annotated block

this is another string'.
	self assert: result trimBoth equals: '<h1>This is a title</h1>', newLine ,
'<section id="LabelOfAnnotatedBlock"><label for="LabelOfAnnotatedBlock">Body of annotated block</label></section>', newLine ,
'<p>this is another string</p>'.
]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCreateAnnotationSimple [

	| result |
	self assert: writer contents equals: String empty.
	
	result := writer convertMicString: '!!LabelOfAnnotatedBlock Body of annotated block'.
	self assert: result trimBoth equals: '<section id="LabelOfAnnotatedBlock"><label for="LabelOfAnnotatedBlock">Body of annotated block</label></section>'.	

]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCreateCitation [

	| result |
	self assert: writer contents equals: String empty.
	
	result := writer convertMicString: '{!citation|ref=Duca99a!}'.
	self assert: result trimBoth equals: '<p><cite>Duca99a</cite></p>'.	

]

{ #category : 'tests' }
MicHTMLVisitorTest >> testCreateItalic [

	| result |
	self assert: writer contents equals: String empty.
	
	result := writer convertMicString: '_Text with italic_'.
	self assert: result trimBoth equals: '<p><i>Text with italic</i></p>'.	

]

{ #category : 'tests' }
MicHTMLVisitorTest >> testVisitAnchor [

	self assert: writer contents equals: String empty.
	writer visitAnchor: (MicAnchorBlock new label: 'target').
	self assert: writer contents equals: '<a id="target"></a>'.

]

{ #category : 'accessing' }
MicHTMLVisitorTest >> writer: aWriter [
	writer := aWriter new
]
