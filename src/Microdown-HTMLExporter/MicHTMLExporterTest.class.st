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

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testAccents [

	self parse: 'éà' andCheckWeGet:  '
<p>&eacute;&agrave;</p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testComment [

self parse: factory commentSample andCheckWeGet: '<!></!>'
															  
]

{ #category : #tests }
MicHTMLExporterTest >> testFigure [

self parse: factory figureSample andCheckWeGet: '
<p><img src="/anUrl?label=figureTest&size=80"/></p>'
															  
]

{ #category : #tests }
MicHTMLExporterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: writer usedNewLine , '<h1>Foo</h1>'
	
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testLink [
	| mic |
	mic := parser parse: factory linkSample.
	
	self assert: (writer visit: mic) contents equals: '
<p><a href="/anUrl"</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testOrderedList [

	self parse: factory orderedListSample andCheckWeGet:  writer usedNewLine ,'
<ol>
<li>Foo</li>
</ol>'
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: writer usedNewLine ,'<p>Foo</p>'
]

{ #category : #'tests - paragraph' }
MicHTMLExporterTest >> testParagraphLongWithAccents [

	self parse: factory paragraphOnMultipleLinesSample andCheckWeGet:  '
<p>Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit &agrave; l''oblit&eacute;ration totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera pass&eacute;e, je tournerai mon oeil interieur sur son chemin. Et l&agrave; o&ugrave; elle sera pass&eacute;e, il n''y aura plus rien, rien que moi.</p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphNestedSample [

	self parse: factory paragraphNestedSample andCheckWeGet:  '
<p>this is a <strong><em>paragraph</em></strong></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithBold [

	self parse: factory paragraphBoldSample andCheckWeGet:  '
<p>this is a <strong>paragraph</strong></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet:  '
<p>this is a <em>paragraph</em></p>'
]

{ #category : #'tests - formats' }
MicHTMLExporterTest >> testParagraphWithMonospace [

	self parse: factory paragraphMonospaceSample andCheckWeGet:  '
<p>this is a <code>paragraph</code></p>'
]

{ #category : #tests }
MicHTMLExporterTest >> testTable [

self parse: factory tableSample andCheckWeGet: '<table style="border:"></table>'
															  
]

{ #category : #'tests - list' }
MicHTMLExporterTest >> testUnorderedBoldList [

	self
		parse: factory unorderedListWithTwoItemsBoldSample
		andCheckWeGet: '
<ul>
<li><strong>Foo</strong></li>

<li><strong>Bar</strong></li>
</ul>'
]

{ #category : #'tests - list' }
MicHTMLExporterTest >> testUnorderedList [

	self parse: factory unorderedListWithTwoItemsSample andCheckWeGet: '
<ul>
<li>Foo</li>

<li>Bar</li>
</ul>'
]
