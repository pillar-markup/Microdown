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
