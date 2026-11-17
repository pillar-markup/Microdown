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

{ #category : 'tests' }
MicHTMLExporterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicHTMLVisitor };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf . String crlf };
		  yourself
]

{ #category : 'accessing' }
MicHTMLExporterTest >> factory: aFactory [
	self flag: #todo.
	"This is horrible either factory: should be renamed factoryClass or we should remove the new."
	factory := aFactory new
]

{ #category : 'helpers' }
MicHTMLExporterTest >> headerFoo: anIdOrNil [
	"Answer a document with the header Foo of level 2, with anIdOrNil as #id property when it is not nil."

	| document |
	document := Microdown parse: '## Foo'.
	anIdOrNil ifNotNil: [
		document children first propertyAt: #id put: anIdOrNil ].
	^ document
]

{ #category : 'tests - figures' }
MicHTMLExporterTest >> imgTagOf: aMicrodownString [
	"Answer the img tag MicHTMLVisitor writes for aMicrodownString."

	| html start |
	html := MicHTMLVisitor new
		        visit: (Microdown parse: aMicrodownString);
		        contents.
	start := html indexOfSubCollection: '<img'.
	^ html copyFrom: start to: (html indexOf: $> startingAt: start)
]

{ #category : 'accessing' }
MicHTMLExporterTest >> newLine [

	^ newLine
]

{ #category : 'accessing' }
MicHTMLExporterTest >> newLine: aNewLine [
	(aNewLine = String cr) ifTrue:[ writer crAsNewLine ].
	(aNewLine = String lf) ifTrue:[ writer lfAsNewLine ].
	(aNewLine = String crlf) ifTrue:[ writer crlfAsNewLine ].
	newLine := aNewLine
]

{ #category : 'tests - paragraph' }
MicHTMLExporterTest >> newLineParagraphAround: aString [

	^ newLine, '<p>', aString, '</p>', newLine
]

{ #category : 'tests - list' }
MicHTMLExporterTest >> orderedListString [

^  '
Here is a list:
1. item 1
2. item 2
3. item 3
'
]

{ #category : 'utilities' }
MicHTMLExporterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic c |
	mic := parser parse: 	aString.
	writer visit: mic.
	c := writer contents. 
	self assert: c equals: aResultingString.
	^ c
]

{ #category : 'utilities' }
MicHTMLExporterTest >> parser [
	^ parser
]

{ #category : 'accessing' }
MicHTMLExporterTest >> parser: aParser [
	parser := aParser new
]

{ #category : 'tests - paragraph' }
MicHTMLExporterTest >> pharoPage [

	^ 
	'{
"title" : "About Pharo",
"layout" : "index",
"publishDate" : "2025-06-01"
}

# Pharo

[Pharo](http://www.pharo.org) is a beautiful dynamically-typed reflective pure object-oriented language that we have been developing since 2008.
It is inspired by Smalltalk (I''m extremely grateful to Alan Kay and Dan Ingalls - they were so visionary and right). Now our vision for Pharo is to reinvent Smalltalk and produce a better system. 
From that perspective, I''m used to say that Pharo is what we have and not what we want. 
In essence, Pharo is the beginning of the journey and not the final goal. And you can change its future.

You can check what companies are saying about it: [Video](https://youtu.be/6tdkKNX2g4s)

There are many aspects I would like to see being explored either by us or by others.
If you want to explore some of the following aspects, please go and let us know. 
I''m really interested in any topics that evolve Pharo into a better Pharo. 

'
]

{ #category : 'tests - paragraph' }
MicHTMLExporterTest >> testAccents [

	self parse: 'éà' andCheckWeGet: (self newLineParagraphAround:
'éà')
]

{ #category : 'utilities' }
MicHTMLExporterTest >> testAnchor [

	self parse: factory anchorSample andCheckWeGet:  '<a id="test"></a>'
	
]

{ #category : 'tests - anchor references' }
MicHTMLExporterTest >> testAnchorReferenceWithAPageLinksToThatPage [

	| document |
	document := Microdown parse: 'See *@toto@*.'.
	(document children first children detect: [ :each |
		 each isAnchorReferenceBlock ])
		propertyAt: #page
		put: 'chapter-2.html'.

	writer visit: document.

	self assert: (writer contents includesSubstring:
			 '<a href="chapter-2.html#toto">toto</a>')
]

{ #category : 'tests - anchor references' }
MicHTMLExporterTest >> testAnchorReferenceWithoutPageLinksInsideItsPage [

	writer visit: (Microdown parse: 'See *@toto@*.').

	self assert:
		(writer contents includesSubstring: '<a href="#toto">toto</a>')
]

{ #category : 'utilities' }
MicHTMLExporterTest >> testCodeCreatesInnerText [

	| code |
	code := (self parser parse: '```a b```') children first.
	self assert: code class equals: MicCodeBlock.
	self assert: code language equals: 'a b```'
]

{ #category : 'tests - anchor ids' }
MicHTMLExporterTest >> testCodeWithAnchorWritesItsId [

	writer visit: (Microdown parse: '```anchor=code1
foo
```').

	self assert: (writer contents includesSubstring:
			 '<pre id="code1"><code>foo</code></pre>')
]

{ #category : 'tests - anchor ids' }
MicHTMLExporterTest >> testCodeWithoutAnchorWritesNoId [

	writer visit: (Microdown parse: '```
foo
```').

	self assert:
		(writer contents includesSubstring: '<pre><code>foo</code></pre>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testCodeWithoutParam [

	| doc |
	doc := (parser parse: '```
ab
foo bar
```') children first.
	writer visit: doc.
	self assert: writer contents equals: newLine ,
'<pre><code>ab', newLine ,
'foo bar</code></pre>', newLine
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigure [

	self
		parse: factory figureSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo" class="figureTest" style="width: 80%"><figcaption>Foo</figcaption></img></figure>')
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testFigureBold [

	self
		parse: factory figureBoldSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo" class="figureTest" style="width: 80%"><figcaption><strong>Foo</strong></figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureItalic [

	self
		parse: factory figureItalicSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo" class="figureTest" style="width: 80%"><figcaption><i>Foo</i></figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureNested [

	self
		parse: factory figureNestedSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo_" class="figureTest" style="width: 80%"><figcaption><strong>Foo_</strong></figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureReal [

	self
		parse: factory figureRealSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="figures/logo.png" alt="A logo png under figures folder" class="figureTest" style="width: 80%"><figcaption>A logo png under figures folder</figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureStrike [

	self
		parse: factory figureStrikeSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo" class="figureTest" style="width: 80%"><figcaption><strike>Foo</strike></figcaption></img></figure>')
]

{ #category : 'tests - figures' }
MicHTMLExporterTest >> testFigureWidthIsAPercentageOfTheTextWidth [
	"In Microdown the width of a figure is a percentage of the text width (see MicLaTeXWriter>>writeGraphicsParametersOfExternalLink:); the HTML width attribute would mean pixels."

	self assert: (self imgTagOf: '![cap %width=50](f.png)') equals: '<img src="f.png" alt="cap " style="width: 50%">'
]

{ #category : 'tests - anchor ids' }
MicHTMLExporterTest >> testFigureWithAnchorWritesItsId [

	writer visit:
		(Microdown parse: '![A caption.%anchor=fig1](figures/x.png)').

	self assert:
		(writer contents includesSubstring: '<figure id="fig1">')
]

{ #category : 'tests - anchor ids' }
MicHTMLExporterTest >> testFigureWithAnchorWrittenForATemplatedWriterWithoutFigureTemplateWritesItsId [

	| maker |
	maker := MicTHTMLDocumentMaker new
		         templateDirectory: FileSystem memory / 'noTemplates';
		         yourself.

	self assert: ((maker write:
			  (Microdown parse: '![A caption.%anchor=fig1](figures/x.png)'))
			 includesSubstring: '<figure id="fig1">')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureWithLabelWithoutSize [

	self
		parse: factory figureWithLabelWithoutSizeSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="Foo" class="figureTest"><figcaption>Foo</figcaption></img></figure>')
]

{ #category : 'tests - anchor ids' }
MicHTMLExporterTest >> testFigureWithoutAnchorWritesNoId [

	writer visit: (Microdown parse: '![A caption.](figures/x.png)').

	self assert: (writer contents includesSubstring: '<figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureWithoutCaption [

	self
		parse: factory figureWithoutCaptionSample
		andCheckWeGet: (self newLineParagraphAround:
				 '<figure id="figureTest"><img src="/anUrl" alt="" class="figureTest" style="width: 80%"><figcaption></figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testFigureWithoutSizeAndLabel [

	self 
		parse: factory figureSampleWithoutSizeAndLabel 
		andCheckWeGet: (self newLineParagraphAround:
'<figure><img src="/anUrl" alt="Foo"><figcaption>Foo</figcaption></img></figure>')
]

{ #category : 'tests - figures' }
MicHTMLExporterTest >> testFigureWithoutWidth [

	self assert: (self imgTagOf: '![cap](f.png)') equals: '<img src="f.png" alt="cap">'
]

{ #category : 'tests' }
MicHTMLExporterTest >> testGoutDeFraise [

	self 
		parse: factory figureGoutDeFraise 
		andCheckWeGet: (self newLineParagraphAround:
'<figure><img src="un-gout-de-fraise.jpg" alt="Proposition pour le thème :  Un goût de fraise"><figcaption>Proposition pour le thème : <i>Un goût de fraise</i></figcaption></img></figure>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testHeaderLevel1 [

	self 
		parse: factory headerLevel1Sample 
		andCheckWeGet: newLine , '<h1>Foo</h1>'
	
]

{ #category : 'tests' }
MicHTMLExporterTest >> testHeaderLevel2 [

	self
		parse: factory headerLevel2Sample
		andCheckWeGet: newLine , '<h2>Foo</h2>'
]

{ #category : 'tests - header ids' }
MicHTMLExporterTest >> testHeaderWithIdWritesItsId [

	writer visit: (self headerFoo: 'foo').

	self
		assert: writer contents
		equals: newLine , '<h2 id="foo">Foo</h2>'
]

{ #category : 'tests - header ids' }
MicHTMLExporterTest >> testHeaderWithIdWrittenForATemplatedWriterWithoutHeaderTemplateWritesItsId [

	| maker |
	maker := MicTHTMLDocumentMaker new
		         templateDirectory: FileSystem memory / 'noTemplates';
		         yourself.

	self assert:
		((maker write: (self headerFoo: 'foo')) includesSubstring:
			 '<h2 id="foo">Foo</h2>')
]

{ #category : 'tests - header ids' }
MicHTMLExporterTest >> testHeaderWithoutIdWritesNoId [

	writer visit: (self headerFoo: nil).

	self assert: writer contents equals: newLine , '<h2>Foo</h2>'
]

{ #category : 'tests - metadata' }
MicHTMLExporterTest >> testMetaDataIsIgnored [

	self parse: factory metaDataSample andCheckWeGet: ''
]

{ #category : 'tests - metadata' }
MicHTMLExporterTest >> testMetaDataIsNotIgnored [

	writer doNotIgnoreMetaData.
	self parse: factory metaDataSample andCheckWeGet: ''
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

{ #category : 'tests - paragraph' }
MicHTMLExporterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: (self newLineParagraphAround: 'Foo')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testParagraphLongWithAccents [

	self parse: factory paragraphOnMultipleLinesSample andCheckWeGet: (self newLineParagraphAround:
'Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit à l''oblitération totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera passée, je tournerai mon oeil interieur sur son chemin. Et là où elle sera passée, il n''y aura plus rien, rien que moi.')
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testParagraphNestedSample [

	self parse: factory paragraphNestedSample andCheckWeGet:  (self newLineParagraphAround: 
'this is a <strong><i>paragraph</i></strong>')
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testParagraphWithBold [

	self 
		parse: factory paragraphBoldSample 
		andCheckWeGet:  (self newLineParagraphAround:
'this is a <strong>paragraph</strong>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet: (self newLineParagraphAround: 
'this is a <i>paragraph</i>')
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testParagraphWithMonospace [

	self parse: factory paragraphMonospaceSample andCheckWeGet:  (self newLineParagraphAround: 
'this is a <code>paragraph</code>')
]

{ #category : 'tests - paragraph' }
MicHTMLExporterTest >> testPharoPage [

	self parse: self pharoPage andCheckWeGet: newLine, '<h1>Pharo</h1>', newLine, 
'<p><a target="_blank" href="http://www.pharo.org/">Pharo</a> is a beautiful dynamically-typed reflective pure object-oriented language that we have been developing since 2008.<br>It is inspired by Smalltalk (I''m extremely grateful to Alan Kay and Dan Ingalls - they were so visionary and right). Now our vision for Pharo is to reinvent Smalltalk and produce a better system.<br>From that perspective, I''m used to say that Pharo is what we have and not what we want.<br>In essence, Pharo is the beginning of the journey and not the final goal. And you can change its future.</p>', newLine, newLine, 

'<p>You can check what companies are saying about it: <a target="_blank" href="https://youtu.be/6tdkKNX2g4s">Video</a></p>', newLine, newLine,

'<p>There are many aspects I would like to see being explored either by us or by others.<br>If you want to explore some of the following aspects, please go and let us know.<br>I''m really interested in any topics that evolve Pharo into a better Pharo.</p>', newLine
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet: 
	'<q>Foo</q>'
]

{ #category : 'tests - raw' }
MicHTMLExporterTest >> testRawOnMultipleLinesIsNotRawButTwoPargraphs [

	| mic |
	mic := parser  
		parse: 'some text here!{{  <a class="btn btn-block download" href="https://files.pharo.org/pharo-launcher/mac-arm64"> ', self newLine,'
            <i class="fa fa-apple"></i> macOs arm64</a>  }}...and there'.
	"notice that I did on purpose that I do not have space around"

	self assert: mic children size equals: 2.
	self assert: mic children first class equals: MicParagraphBlock .
	self assert: mic children second class equals: MicParagraphBlock .
	
 
 
]

{ #category : 'tests - raw' }
MicHTMLExporterTest >> testRawOnSingleLineShouldNotGoToTheNextLine [

	| mic |
	mic := parser  
		parse: 'some text here!{{  <a class="btn btn-block download" href="https://files.pharo.org/pharo-launcher/mac-arm64">   <i class="fa fa-apple"></i> macOs arm64</a>  }}...and there'.
	"notice that I did on purpose that I do not have space around"
	
	writer visit: mic children first.
 	self 
		assert: writer contents 
		equals: 
		(
self newLine, '<p>some text here!  <a class="btn btn-block download" href="https://files.pharo.org/pharo-launcher/mac-arm64">   <i class="fa fa-apple"></i> macOs arm64</a>  ...and there</p>', self newLine

 )
	
	
]

{ #category : 'tests - formats' }
MicHTMLExporterTest >> testStrike [

	self parse: factory strikethroughFormatSample andCheckWeGet: (self newLineParagraphAround: 
'<strike>Foo</strike>')
]

{ #category : 'tests' }
MicHTMLExporterTest >> testTable [

	| micTable |
	micTable := parser parse: factory tableSample.
	writer visit: micTable.
	self assert: writer contents equals: newLine ,
'<table>', newLine ,
'<tr><th>aaab</th><th>jkhjh</th></tr>', newLine ,
'<tr><td>bar</td><td>rab</td></tr>', newLine ,
'</table>'
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

{ #category : 'accessing' }
MicHTMLExporterTest >> writer: aWriter [
	writer := aWriter new
]
