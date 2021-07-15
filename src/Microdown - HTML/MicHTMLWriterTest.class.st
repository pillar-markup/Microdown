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
MicHTMLWriterTest >> testAnchor [
	| mic |
	mic := parser parse: (factory anchorSample).
	self assert: (writer start: mic) contents equals: '<a id="test"></a>'
]

{ #category : #tests }
MicHTMLWriterTest >> testAnnotated [
	| mic |
	mic := parser parse: (factory annotatedSample).
	self assert: (writer start: mic) contents equals: '<p class="label">
Foo <em>bar</em></p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testBold [
	| mic |
	mic := parser parse: factory boldFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<strong>Foo</strong>
</p>'
]

{ #category : #'tests - codeblock' }
MicHTMLWriterTest >> testCodeblock [
	| mic |
	mic := parser parse: (factory codeblockNoParamBody: 'this is a code').
	self assert: (writer start: mic) contents equals: '<figure><pre><code>this is a code</code></pre></figure>
'
]

{ #category : #'tests - codeblock' }
MicHTMLWriterTest >> testCodeblockWithCaption [
	| mic |
	mic := parser parse: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: (writer start: mic) contents equals: '<figure><pre><code class="caption">this is a code</code><figcaption>Pharo is <strong>cool</strong></figcaption></pre></figure>
'
]

{ #category : #'tests - codeblock' }
MicHTMLWriterTest >> testCodeblockWithParameters [
	| mic |
	mic := parser parse: (factory codeblock: 'language=Smalltalk&size=42' body: 'this is a code').
	self assert: (writer start: mic) contents equals: '<figure><pre><code class="Smalltalk">this is a code</code><figcaption></figcaption></pre></figure>
'
]

{ #category : #tests }
MicHTMLWriterTest >> testColumn [
	| mic |
	mic := parser parse: (factory columnSample).
	self assert: (writer start: mic) contents equals: '<div class="column" style="float:left; margin:0; width:42%;"><p>
this is a <strong>text</strong>
</p></div>
'
]

{ #category : #'tests - columns' }
MicHTMLWriterTest >> testColumns [
	| mic |
	mic := parser parse: (factory columnsSample).
	self assert: (writer start: mic) contents equals: '<div class="columns" style="margin:0px auto; width:100%"></div>
'
]

{ #category : #'tests - columns' }
MicHTMLWriterTest >> testColumnsWithChildren [
	| mic |
	mic := parser parse: (factory columnsWithChildrenSample).
	self assert: (writer start: mic) contents equals: '<div class="columns" style="margin:0px auto; width:100%"><div class="column" style="float:left; margin:0; width:42%;"><p>
this is a <strong>text</strong>
</p></div>
<div class="column" style="float:left; margin:0; width:42%;"><p>
this is a <strong>text</strong>
</p></div>
</div>
'
]

{ #category : #'tests - references' }
MicHTMLWriterTest >> testFigure [
	| mic |
	mic := parser parse: factory figureSample.
	self assert: (writer start: mic) contents equals: '<p>
<a id="/anUrl?label=figureTest&size=80"></a>
<figure>
	<img src="/anUrl?label=figureTest&size=80" alt=""/>
	<figcaption>Foo</figcaption>
</figure>
</p>'
]

{ #category : #'tests - references' }
MicHTMLWriterTest >> testFigureBold [
	| mic |
	mic := parser parse: factory figureBoldSample.
	self assert: (writer start: mic) contents equals: '<p>
<a id="/anUrl?label=figureTest&size=80"></a>
<figure>
	<img src="/anUrl?label=figureTest&size=80" alt="**Foo**"/>
	<figcaption><strong>Foo</strong></figcaption>
</figure>
</p>'
]

{ #category : #tests }
MicHTMLWriterTest >> testFootnote [
	| mic |
	mic := parser parse: (factory footnoteSample).
	self assert: (writer start: mic) contents equals: '<p>
<sup><a href="#footnote1">[1]</a></sup>
</p>
<hr></hr>
<sup id="footnote1">[1] Pharo is cool</sup><br/>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel1HTML [
	| mic |
	mic := parser parse: factory headerLevel1Sample.
	self assert: (writer start: mic) contents equals: '<h1>Foo</h1>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel2HTML [
	| mic |
	mic := parser parse: factory headerLevel2Sample.
	self assert: (writer start: mic) contents equals: '<h2>Foo</h2>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel3HTML [
	| mic |
	mic := parser parse: factory headerLevel3Sample.
	self assert: (writer start: mic) contents equals: '<h3>Foo</h3>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel4HTML [
	| mic |
	mic := parser parse: factory headerLevel4Sample.
	self assert: (writer start: mic) contents equals: '<h4>Foo</h4>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel5HTML [
	| mic |
	mic := parser parse: factory headerLevel5Sample.
	self assert: (writer start: mic) contents equals: '<h5>Foo</h5>
'
]

{ #category : #'tests - header' }
MicHTMLWriterTest >> testHeaderLevel6HTML [
	| mic |
	mic := parser parse: factory headerLevel6Sample.
	self assert: (writer start: mic) contents equals: '<h6>Foo</h6>
'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testItalic [
	| mic |
	mic := parser parse: factory italicFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<em>Foo</em>
</p>'
]

{ #category : #'tests - references' }
MicHTMLWriterTest >> testLink [
	| mic |
	mic := parser parse: factory linkSample.
	self assert: (writer start: mic) contents equals: '<p>
<a href="/anUrl">Foo</a>
</p>'
]

{ #category : #'tests - references' }
MicHTMLWriterTest >> testLinkBold [
	| mic |
	mic := parser parse: factory linkBoldSample.
	self assert: (writer start: mic) contents equals: '<p>
<a href="/anUrl"><strong>Foo</strong></a>
</p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testMonospace [
	| mic |
	mic := parser parse: factory monospaceFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<code>Foo</code>
</p>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testNested [
	| mic |
	mic := parser parse: factory nestedBoldFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<em><strong>Foo</strong></em>
</p>'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testOrderedList [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsSample.
	self assert: (writer start: mic) contents equals: '<ol><li>first</li>
<li>second</li>
</ol>
'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testOrderedListBold [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsBoldSample.
	self assert: (writer start: mic) contents equals: '<ol><li><strong>first</strong></li>
<li>second</li>
</ol>
'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testOrderedListNested [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsNestedSample.
	self assert: (writer start: mic) contents equals: '<ol><li><strong><em>first</em></strong></li>
<li>second</li>
</ol>
'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraph [
	| mic |
	mic := parser parse: factory paragraphSample.
	self assert: (writer start: mic) contents equals: '<p>
Foo
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithBold [
	| mic |
	mic := parser parse: factory paragraphBoldSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <strong>paragraph</strong>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithItalic [
	| mic |
	mic := parser parse: factory paragraphItalicSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <em>paragraph</em>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithMonospace [
	| mic |
	mic := parser parse: factory paragraphMonospaceSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <code>paragraph</code>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithNested [
	| mic |
	mic := parser parse: factory paragraphNestedSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <strong><em>paragraph</em></strong>
</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLWriterTest >> testParagraphWithStrike [
	| mic |
	mic := parser parse: factory paragraphStrikeSample.
	self assert: (writer start: mic) contents equals: '<p>
this is a <s>paragraph</s>
</p>'
]

{ #category : #tests }
MicHTMLWriterTest >> testQuote [
	| mic |
	mic := parser parse: (factory quoteSample).
	self assert: (writer start: mic) contents equals: '<pre>Foo</pre>'
]

{ #category : #'tests - formats' }
MicHTMLWriterTest >> testStrike [
	| mic |
	mic := parser parse: factory strikethroughFormatSample.
	self assert: (writer start: mic) contents equals: '<p>
<s>Foo</s>
</p>'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testUnorderedList [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsSample.
	self assert: (writer start: mic) contents equals: '<ul>
<li>Foo</li>
<li>Bar</li>
</ul>
'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testUnorderedListBold [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsBoldSample.
	self assert: (writer start: mic) contents equals: '<ul>
<li><strong>Foo</strong></li>
<li>Bar</li>
</ul>
'
]

{ #category : #'tests - lists' }
MicHTMLWriterTest >> testUnorderedListNested [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsNestedSample.
	self assert: (writer start: mic) contents equals: '<ul>
<li><s><em>Foo</em></s></li>
<li>Bar</li>
</ul>
'
]
