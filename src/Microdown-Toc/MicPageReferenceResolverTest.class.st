"
I check that `MicPageReferenceResolver` marks the references to an anchor of another page with that page, including figures and the chapters of a split book, and leaves unmarked the references to their own page and to unknown anchors.
"
Class {
	#name : 'MicPageReferenceResolverTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicPageReferenceResolverTest >> numberOfReferenceIn: aDocument [

	^ (self referenceIn: aDocument) propertyAt: #number ifAbsent: [ nil ]
]

{ #category : 'helpers' }
MicPageReferenceResolverTest >> pageOfReferenceIn: aDocument [

	^ (self referenceIn: aDocument) propertyAt: #page ifAbsent: [ nil ]
]

{ #category : 'helpers' }
MicPageReferenceResolverTest >> referenceIn: aDocument [
	"Answer the first anchor reference of the paragraphs of aDocument."

	aDocument children do: [ :block |
			(block children
				 detect: [ :each | each isAnchorReferenceBlock ]
				 ifNone: [ nil ]) ifNotNil: [ :reference | ^ reference ] ].
	^ nil
]

{ #category : 'helpers' }
MicPageReferenceResolverTest >> resolve: aCollectionOfPages [
	"Resolve the references of the pages, given as pairs page name -> Microdown text; answer the documents by page name."

	| pages |
	pages := aCollectionOfPages collect: [ :each |
		         each key -> (Microdown parse: each value) ].
	MicPageReferenceResolver new resolve: pages.
	^ (pages collect: [ :each | each key -> each value ]) asDictionary
]

{ #category : 'helpers' }
MicPageReferenceResolverTest >> resolveBook: aString [
	"Number the book of aString, split it into chapter pages (chapter-1.html, …) and resolve its references, as a book site does; answer the chapters."

	| book splitter |
	book := Microdown parse: aString.
	MicNumberer new number: book.
	splitter := MicChapterSplitter new.
	splitter split: book.
	MicPageReferenceResolver new resolve:
		(splitter chapters withIndexCollect: [ :each :index |
				 (String streamContents: [ :stream |
					  stream << 'chapter-' << index printString << '.html' ]) -> each ]).
	^ splitter chapters
]

{ #category : 'tests - example' }
MicPageReferenceResolverTest >> testExampleOfTwoChapters [

	| pages |
	pages := MicPageReferenceResolver exampleOfTwoChapters pages.

	self
		assert: (pages collect: [ :each | each key ] as: Array)
		equals: #( 'chapter-1.html' 'chapter-2.html' ).
	self
		assert: (self pageOfReferenceIn: pages first value)
		equals: 'chapter-2.html'.
	self
		assert: (self numberOfReferenceIn: pages first value)
		equals: #( 2 )
]

{ #category : 'tests - references' }
MicPageReferenceResolverTest >> testReferenceBetweenChaptersOfASplitBook [

	| splitter pages |
	splitter := MicChapterSplitter new
		            split: (Microdown parse: '## One

See *@two@*.

## Two
@two');
		            yourself.
	pages := splitter chapters withIndexCollect: [ :each :index |
			         (String streamContents: [ :stream |
				          stream << 'chapter-' << index printString << '.html' ])
			         -> each ].

	MicPageReferenceResolver new resolve: pages.

	self
		assert: (self pageOfReferenceIn: splitter chapters first)
		equals: 'chapter-2.html'
]

{ #category : 'tests - numbers' }
MicPageReferenceResolverTest >> testReferenceInItsOwnPageGetsANumberButNoPage [

	| chapters |
	chapters := self resolveBook: '## One

### Details
@details

See Section *@details@*.'.

	self
		assert: (self numberOfReferenceIn: chapters first)
		equals: #( 1 1 ).
	self assert: (self pageOfReferenceIn: chapters first) isNil
]

{ #category : 'tests - numbers' }
MicPageReferenceResolverTest >> testReferenceToAFigureOfAnotherChapterGetsItsNumberAndPage [

	| chapters |
	chapters := self resolveBook: '## One

See Figure *@fb@*.

## Two

![A caption.](b.png anchor=fb)'.

	self
		assert: (self numberOfReferenceIn: chapters first)
		equals: #( 2 1 ).
	self
		assert: (self pageOfReferenceIn: chapters first)
		equals: 'chapter-2.html'
]

{ #category : 'tests - references' }
MicPageReferenceResolverTest >> testReferenceToAFigureOfAnotherPageGetsThatPage [

	| documents |
	documents := self resolve: {
			             ('one.html' -> 'See *@fig1@*.').
			             ('two.html'
			              -> '![A caption.%anchor=fig1](figures/x.png)') }.

	self
		assert: (self pageOfReferenceIn: (documents at: 'one.html'))
		equals: 'two.html'
]

{ #category : 'tests - references' }
MicPageReferenceResolverTest >> testReferenceToAnAnchorOfAnotherPageGetsThatPage [

	| documents |
	documents := self resolve: {
			             ('one.html' -> 'See *@toto@*.').
			             ('two.html' -> '## Toto
@toto') }.

	self
		assert: (self pageOfReferenceIn: (documents at: 'one.html'))
		equals: 'two.html'
]

{ #category : 'tests - references' }
MicPageReferenceResolverTest >> testReferenceToAnAnchorOfItsOwnPageGetsNoPage [

	| documents |
	documents := self resolve: {
			             ('one.html' -> '## Toto
@toto

See *@toto@*.').
			             ('two.html' -> 'Other.') }.

	self assert:
		(self pageOfReferenceIn: (documents at: 'one.html')) isNil
]

{ #category : 'tests - references' }
MicPageReferenceResolverTest >> testReferenceToAnUnknownAnchorGetsNoPage [

	| documents |
	documents := self resolve: {
			             ('one.html' -> 'See *@nowhere@*.').
			             ('two.html' -> '## Toto
@toto') }.

	self assert:
		(self pageOfReferenceIn: (documents at: 'one.html')) isNil
]

{ #category : 'tests - numbers' }
MicPageReferenceResolverTest >> testReferenceToAnUnknownLabelGetsNoNumber [

	self assert: (self numberOfReferenceIn: (self resolveBook: '## One

See *@unknown@*.') first) isNil
]

{ #category : 'tests - numbers' }
MicPageReferenceResolverTest >> testReferenceToAnUnnumberedTargetGetsNoNumber [

	| book splitter |
	book := Microdown parse: '@intro

Welcome.

## One

See *@intro@*.'.
	MicNumberer new number: book.
	splitter := MicChapterSplitter new.
	splitter split: book.

	MicPageReferenceResolver new resolve: {
			('index.html' -> splitter frontMatter).
			('chapter-1.html' -> splitter chapters first) }.

	self
		assert: (self pageOfReferenceIn: splitter chapters first)
		equals: 'index.html'.
	self assert:
		(self numberOfReferenceIn: splitter chapters first) isNil
]
