"
I check that `MicBookHTMLVisitor` shows the numbers of headers, figure captions, listings and references, links numbered references to their page, writes elements without number as `MicHTMLVisitor` does, and that `MicHTMLVisitor` itself shows no number.
"
Class {
	#name : 'MicBookHTMLVisitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicBookHTMLVisitorTest >> document: aString numbering: anArray [
	"Parse aString and give anArray as #number, as MicNumberer would, to its first element when it is a header, else to the anchor reference (or else the first element, a figure) of its first paragraph."

	| document element |
	document := Microdown parse: aString.
	element := document children first.
	element isHeader ifFalse: [
			element := element children
				           detect: [ :each | each isAnchorReferenceBlock ]
				           ifNone: [ element children first ] ].
	element propertyAt: #number put: anArray.
	^ document
]

{ #category : 'helpers' }
MicBookHTMLVisitorTest >> htmlOf: aDocument [

	^ MicBookHTMLVisitor new
		  visit: aDocument;
		  contents
]

{ #category : 'tests - listings' }
MicBookHTMLVisitorTest >> testCodeBlockWithoutCaptionOrNumberIsWrittenAsUsual [

	| html |
	html := self htmlOf: (Microdown parse: '```
foo
```').

	self assert: (html includesSubstring: '<pre><code>foo').
	self deny: (html includesSubstring: 'figure')
]

{ #category : 'tests - example' }
MicBookHTMLVisitorTest >> testExampleOfAChapterPage [

	| html |
	html := MicBookHTMLVisitor exampleOfAChapterPage contents.

	self assert: (html includesSubstring:
			 '<h2><span class="number">1</span> First chapter</h2>').
	self assert: (html includesSubstring:
			 'As said in Chapter <a href="chapter-2.html#second">2</a>.')
]

{ #category : 'tests - figures' }
MicBookHTMLVisitorTest >> testFigureWithoutNumberHasItsCaptionOnly [

	self assert:
		((self htmlOf: (Microdown parse: '![A caption.](a.png)'))
			 includesSubstring: '<figcaption>A caption.</figcaption>')
]

{ #category : 'tests - headers' }
MicBookHTMLVisitorTest >> testHeaderWithoutNumberIsWrittenAsUsual [

	self assert:
		((self htmlOf: (Microdown parse: '## Foo')) includesSubstring:
			 '<h2>Foo</h2>')
]

{ #category : 'tests - listings' }
MicBookHTMLVisitorTest >> testListingIsEscaped [

	self assert: ((self htmlOf: (Microdown parse: '```caption=Hello
a < b
```')) includesSubstring: '<code>a &lt; b</code>')
]

{ #category : 'tests - listings' }
MicBookHTMLVisitorTest >> testListingWithACaptionAndNoNumberShowsItsCaption [

	self assert: ((self htmlOf: (Microdown parse: '```caption=Hello
foo
```')) includesSubstring: '<figcaption>Hello</figcaption>')
]

{ #category : 'tests - plain writer' }
MicBookHTMLVisitorTest >> testMicHTMLVisitorShowsNoNumber [

	self assert: ((MicHTMLVisitor new
			  visit: (self document: '### Foo' numbering: #( 1 2 ));
			  contents) includesSubstring: '<h3>Foo</h3>')
]

{ #category : 'tests - figures' }
MicBookHTMLVisitorTest >> testNumberedFigureCaptionStartsWithItsNumber [

	self assert: ((self htmlOf:
			  (self
				   document: '![A caption.](a.png anchor=fa)'
				   numbering: #( 1 1 ))) includesSubstring:
			 '<figcaption><span class="number">Figure 1.1</span> A caption.</figcaption>')
]

{ #category : 'tests - headers' }
MicBookHTMLVisitorTest >> testNumberedHeaderKeepsItsId [

	| document |
	document := self document: '## Foo' numbering: #( 3 ).
	document children first propertyAt: #id put: 'foo'.

	self assert: ((self htmlOf: document) includesSubstring:
			 '<h2 id="foo"><span class="number">3</span> Foo</h2>')
]

{ #category : 'tests - headers' }
MicBookHTMLVisitorTest >> testNumberedHeaderShowsItsNumber [

	self assert:
		((self htmlOf: (self document: '### Foo' numbering: #( 1 2 )))
			 includesSubstring: '<h3><span class="number">1.2</span> Foo</h3>')
]

{ #category : 'tests - listings' }
MicBookHTMLVisitorTest >> testNumberedListingIsACodeFigureWithItsNumberAndCaption [

	| document html |
	document := Microdown parse: '```caption=Hello&anchor=l1
foo
```'.
	document children first propertyAt: #number put: #( 1 1 ).

	html := self htmlOf: document.

	self assert:
		(html includesSubstring:
			 '<figure class="code" id="l1"><pre><code>foo').
	self assert: (html includesSubstring:
			 '<figcaption><span class="number">Listing 1.1</span> Hello</figcaption></figure>')
]

{ #category : 'tests - listings' }
MicBookHTMLVisitorTest >> testNumberedListingWithoutCaptionShowsItsNumber [

	| document |
	document := Microdown parse: '```anchor=l1
foo
```'.
	document children first propertyAt: #number put: #( 2 3 ).

	self assert: ((self htmlOf: document) includesSubstring:
			 '<figcaption><span class="number">Listing 2.3</span> </figcaption>')
]

{ #category : 'tests - references' }
MicBookHTMLVisitorTest >> testNumberedReferenceToAnotherPageLinksToThatPage [

	| document |
	document := self document: 'See *@fb@*.' numbering: #( 2 1 ).
	(document children first children detect: [ :each |
		 each isAnchorReferenceBlock ])
		propertyAt: #page
		put: 'chapter-2.html'.

	self assert: ((self htmlOf: document) includesSubstring:
			 '<a href="chapter-2.html#fb">2.1</a>')
]

{ #category : 'tests - headers' }
MicBookHTMLVisitorTest >> testParagraphHeaderHasTheParagraphClass [

	self assert: ((self htmlOf: (Microdown parse: '## Chapter

##### Important')) includesSubstring:
			 '<h5 class="paragraph">Important</h5>')
]

{ #category : 'tests - headers' }
MicBookHTMLVisitorTest >> testParagraphLevelComesFromTheBook [

	| document |
	document := Microdown parse: '# Chapter

#### Important'.
	document bookStructure: (MicBookStructure chapterLevel: 1).

	self assert: ((self htmlOf: document) includesSubstring:
			 '<h4 class="paragraph">Important</h4>')
]

{ #category : 'tests - references' }
MicBookHTMLVisitorTest >> testReferenceWithANumberShowsTheNumber [

	self assert: ((self htmlOf:
			  (self document: 'See Figure *@fb@*.' numbering: #( 2 1 )))
			 includesSubstring: 'See Figure <a href="#fb">2.1</a>.')
]

{ #category : 'tests - references' }
MicBookHTMLVisitorTest >> testReferenceWithoutNumberShowsItsLabel [

	self assert:
		((self htmlOf: (Microdown parse: 'See *@fb@*.')) includesSubstring:
			 '<a href="#fb">fb</a>')
]
