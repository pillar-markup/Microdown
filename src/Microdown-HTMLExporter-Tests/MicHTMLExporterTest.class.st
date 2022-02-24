Class {
	#name : #MicHTMLExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'writer',
		'factory'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

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

{ #category : #running }
MicHTMLExporterTest >> setUp [
	super setUp.
	parser := Microdown new.
	writer := MicHTMLWriter new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testAccents [

	self parse: 'éà' andCheckWeGet:  '
<p>&eacute;&agrave;</p>'
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
	self assert: code firstTag equals: 'a b```'
]

{ #category : #tests }
MicHTMLExporterTest >> testCodeWithoutParam [

	| doc |
	doc := (parser parse: '```
ab
foo bar
```') children first.
	writer visit: doc.
	self assert: writer contents equals: '
<pre><code>ab
foo bar</code></pre>
'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigure [

	self 
		parse: factory figureSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="Foo" class="figureTest" width="80"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testFigureBold [

	self 
		parse: factory figureBoldSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="**Foo**" class="figureTest" width="80"><figcaption><strong>Foo</strong></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureItalic [

	self 
		parse: factory figureItalicSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="_Foo_" class="figureTest" width="80"><figcaption><em>Foo</em></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureNested [

	self 
		parse: factory figureNestedSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="**Foo_**" class="figureTest" width="80"><figcaption><strong>Foo_</strong></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureReal [

	self 
		parse: factory figureRealSample 
		andCheckWeGet: '
<p><figure><img src="figures/logo.png" alt="A logo png under figures folder" class="figureTest" width="80"><figcaption>A logo png under figures folder</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureStrike [

	self 
		parse: factory figureStrikeSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="~Foo~" class="figureTest" width="80"><figcaption><strike>Foo</strike></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithLabelWithoutSize [

	self 
		parse: factory figureWithLabelWithoutSizeSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="Foo" class="figureTest"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithoutCaption [

	self 
		parse: factory figureWithoutCaptionSample 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="" class="figureTest" width="80"><figcaption></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testFigureWithoutSizeAndLabel [

	self 
		parse: factory figureSampleWithoutSizeAndLabel 
		andCheckWeGet: '
<p><figure><img src="/anUrl" alt="Foo"><figcaption>Foo</figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testGoutDeFraise [

	self 
		parse: factory figureGoutDeFraise 
		andCheckWeGet: '
<p><figure><img src="un-gout-de-fraise.jpg" alt="Proposition pour le thème : _Un goût de fraise_"><figcaption>Proposition pour le th&egrave;me : <em>Un go&ucirc;t de fraise</em></figcaption></img></figure></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel1 [

	self 
		parse: factory headerLevel1Sample 
		andCheckWeGet: writer usedNewLine , '<h1>Foo</h1>'
	
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel2 [

	self
		parse: factory headerLevel2Sample
		andCheckWeGet: writer usedNewLine , '<h2>Foo</h2>'
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: writer usedNewLine ,'<p>Foo</p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphLongWithAccents [

	self parse: factory paragraphOnMultipleLinesSample andCheckWeGet: '
<p>Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit &agrave; l''oblit&eacute;ration totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera pass&eacute;e, je tournerai mon oeil interieur sur son chemin. Et l&agrave; o&ugrave; elle sera pass&eacute;e, il n''y aura plus rien, rien que moi.</p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphNestedSample [

	self parse: factory paragraphNestedSample andCheckWeGet:  '
<p>this is a <strong><em>paragraph</em></strong></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithBold [

	self 
		parse: factory paragraphBoldSample 
		andCheckWeGet:  '
<p>this is a <strong>paragraph</strong></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet: '
<p>this is a <em>paragraph</em></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithMonospace [

	self parse: factory paragraphMonospaceSample andCheckWeGet:  '
<p>this is a <code>paragraph</code></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet: 
	'<q>Foo</q>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testStrike [

	self parse: factory strikethroughFormatSample andCheckWeGet: '
<p><strike>Foo</strike></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testTable [

	| micTable |
	micTable := parser parse: factory tableSample.
	writer visit: micTable.
	self assert: writer contents equals: '
<table>
<tr><th>aaab</th><th>jkhjh</th></tr>
<tr><td>bar</td><td>rab</td></tr>
</table>'
]

{ #category : #'tests - list' }
MicHTMLExporterTest >> testUnorderedList [

	self parse: factory unorderedListWithTwoItemsSample andCheckWeGet: '
<ul>
<li>Foo</li>
<li>Bar</li>
</ul>'
]
