"
I check that `MicBookHTMLVisitor` shows the numbers of headers, figure captions and references, links numbered references to their page, writes elements without number as `MicHTMLVisitor` does, and that `MicHTMLVisitor` itself shows no number.
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
