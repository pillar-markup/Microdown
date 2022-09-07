Class {
	#name : #MicHTMLExporterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'parser',
		'writer',
		'factory',
		'newLine'
	],
	#category : #'Microdown-HTMLExporter-Tests-HTML'
}

{ #category : #tests }
MicHTMLExporterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicHTMLVisitor };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf . String crlf };
		  yourself
]

{ #category : #accessing }
MicHTMLExporterTest >> factory: aFactory [
	factory := aFactory new
]

{ #category : #accessing }
MicHTMLExporterTest >> newLine: aNewLine [
	(aNewLine = String cr) ifTrue:[ writer crAsNewLine ].
	(aNewLine = String lf) ifTrue:[ writer lfAsNewLine ].
	(aNewLine = String crlf) ifTrue:[ writer crlfAsNewLine ].
	newLine := aNewLine
]

{ #category : #utilities }
MicHTMLExporterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |

	mic := parser parse: 	aString.
	writer visit: mic.
	self assert: writer contents equals: aResultingString
]

{ #category : #utilities }
MicHTMLExporterTest >> parser [
	^ parser
]

{ #category : #accessing }
MicHTMLExporterTest >> parser: aParser [
	parser := aParser new
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testAccents [

	self parse: 'éà' andCheckWeGet: newLine,
'<p>éà</p>'
]

{ #category : #utilities }
MicHTMLExporterTest >> testAnchor [

	self parse: factory anchorSample andCheckWeGet:  '<a id="test"></a>'
	
]

{ #category : #utilities }
MicHTMLExporterTest >> testCodeCreatesInnerText [

	| code |
	code := (self parser parse: '```a b```') children first.
	self assert: code class equals: MicCodeBlock.
	self assert: code language equals: 'a b```'
]

{ #category : #tests }
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

{ #category : #tests }
MicHTMLExporterTest >> testFigure [

	self 
		parse: factory figureSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="Foo" class="figureTest" width="80"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testFigureBold [

	self 
		parse: factory figureBoldSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="**Foo**" class="figureTest" width="80"><figcaption><strong>Foo</strong></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureItalic [

	self 
		parse: factory figureItalicSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="_Foo_" class="figureTest" width="80"><figcaption><i>Foo</i></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureNested [

	self 
		parse: factory figureNestedSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="**Foo_**" class="figureTest" width="80"><figcaption><strong>Foo_</strong></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureReal [

	self 
		parse: factory figureRealSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="figures/logo.png" alt="A logo png under figures folder" class="figureTest" width="80"><figcaption>A logo png under figures folder</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureStrike [

	self 
		parse: factory figureStrikeSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="~Foo~" class="figureTest" width="80"><figcaption><strike>Foo</strike></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithLabelWithoutSize [

	self 
		parse: factory figureWithLabelWithoutSizeSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="Foo" class="figureTest"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithoutCaption [

	self 
		parse: factory figureWithoutCaptionSample 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="" class="figureTest" width="80"><figcaption></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithoutSizeAndLabel [

	self 
		parse: factory figureSampleWithoutSizeAndLabel 
		andCheckWeGet: newLine ,
'<p><figure><img src="/anUrl" alt="Foo"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testGoutDeFraise [

	self 
		parse: factory figureGoutDeFraise 
		andCheckWeGet: newLine ,
'<p><figure><img src="un-gout-de-fraise.jpg" alt="Proposition pour le thème : _Un goût de fraise_"><figcaption>Proposition pour le thème : <i>Un goût de fraise</i></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel1 [

	self 
		parse: factory headerLevel1Sample 
		andCheckWeGet: newLine , '<h1>Foo</h1>'
	
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel2 [

	self
		parse: factory headerLevel2Sample
		andCheckWeGet: newLine , '<h2>Foo</h2>'
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: newLine ,'<p>Foo</p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphLongWithAccents [

	self parse: factory paragraphOnMultipleLinesSample andCheckWeGet: newLine ,
'<p>Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit à l''oblitération totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera passée, je tournerai mon oeil interieur sur son chemin. Et là où elle sera passée, il n''y aura plus rien, rien que moi.</p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphNestedSample [

	self parse: factory paragraphNestedSample andCheckWeGet:  newLine ,
'<p>this is a <strong><i>paragraph</i></strong></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithBold [

	self 
		parse: factory paragraphBoldSample 
		andCheckWeGet:  newLine ,
'<p>this is a <strong>paragraph</strong></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet: newLine ,
'<p>this is a <i>paragraph</i></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithMonospace [

	self parse: factory paragraphMonospaceSample andCheckWeGet:  newLine ,
'<p>this is a <code>paragraph</code></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet: 
	'<q>Foo</q>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testStrike [

	self parse: factory strikethroughFormatSample andCheckWeGet: newLine ,
'<p><strike>Foo</strike></p>'
]

{ #category : #tests }
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

{ #category : #'tests - list' }
MicHTMLExporterTest >> testUnorderedList [

	self parse: factory unorderedListWithTwoItemsSample andCheckWeGet: newLine ,
'<ul>', newLine ,
'<li>Foo</li>', newLine ,
'<li>Bar</li>', newLine ,
'</ul>'
]

{ #category : #accessing }
MicHTMLExporterTest >> writer: aWriter [
	writer := aWriter new
]
