"
I write a book as HTML for its web site: as `MicHTMLVisitor`, plus the numbers the book passes left on its elements, so readers see `1.2 Text emphasis`, `Figure 3.1: …` and `See Figure 3.1` instead of `See Figure toto`. `MicHTMLVisitor` stays as it is (writer name `micbasichtml`). With `michtml`, `pillar build html` also uses me, but shows no numbers since it does not run `MicNumberer`.

## Life cycle: who creates me and who uses me

1. The program that writes the pages of a book site creates me (`new`; Pillar finds me by my `writerName`, `michtml`, the default HTML writer of books, so books configured with `""htmlWriter"" : #michtml` get me unchanged), after the passes ran on the book: `MicNumberer` (the `#number` of headers, figures, listings and equations) and `MicPageReferenceResolver` (the `#page` and `#number` of the references).
2. It sends me `visit:` with a page (a chapter) and reads `contents`, as with `MicHTMLVisitor`.

## Responsibility:

- I write a numbered header with its number first: `<h3><span class=""number"">1.2</span> Foo</h3>`.
- I write the caption of a numbered figure starting with `Figure` and its number, and a listing (a code block with a number or a caption) as a code figure, as `codeBlock.mustache` does: `<figure class=""code"" id=""…""><pre><code>…</code></pre><figcaption><span class=""number"">Listing 1.1</span> …</figcaption></figure>`.
- I write a reference to a numbered target with the number as the text of its link (`<a href=""chapter-2.html#fb"">2.1</a>`); the author writes the word before it (`See Figure *@fb@*`). Elements without number are written as `MicHTMLVisitor` does.

## Collaborators: 

- `MicHTMLVisitor`: my superclass, writes everything else.
- `MicNumberer`, `MicPageReferenceResolver`: the passes whose `#number` and `#page` properties I read; `MicNumberer numberStringOf:` formats the numbers.

## Public API and Key Messages

- `visit: aDocument`, then `contents`, as for `MicHTMLVisitor`.
- `MicBookHTMLVisitor writerName` answers `michtml`; `MicHTMLVisitor writerName` answers `micbasichtml`, the plain writer.

## Examples

```
MicBookHTMLVisitor exampleOfAChapterPage.
MicBookHTMLVisitor scriptChapterPage
```

### Implementation Points

- Numbers are written in a `span` of class `number`, so a stylesheet can style them.
- Equations are numbered by `MicNumberer` but not shown yet: `MicHTMLVisitor` does not write math at all (Microdown backlog).
- A code block without number nor caption stays a plain `<pre>` with the anchor as id, as `MicHTMLVisitor` writes it.
- The templated writer (`MicTemplatedWriter`) does not give numbers to its templates yet (phase 2 of the book site).
"
Class {
	#name : 'MicBookHTMLVisitor',
	#superclass : 'MicHTMLVisitor',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicBookHTMLVisitor class >> exampleOfAChapterPage [
	"A visitor that wrote the first chapter page of MicPageReferenceResolver exampleOfTwoChapters (a book numbered, split and resolved): its header shows the number 1 and its reference to the second chapter reads 2, linked to chapter-2.html."

	<sampleInstance>
	^ self new
		  visit:
			  MicPageReferenceResolver exampleOfTwoChapters pages first value;
		  yourself
]

{ #category : 'script' }
MicBookHTMLVisitor class >> scriptChapterPage [
	"Answer the HTML of exampleOfAChapterPage: <h2><span class=number>1</span> First chapter</h2> and As said in Chapter <a href=chapter-2.html#second>2</a>."

	<example>
	^ self exampleOfAChapterPage contents
]

{ #category : 'accessing' }
MicBookHTMLVisitor class >> writerName [
	"The name Pillar finds me by (htmlWriter in pillar.conf): the default HTML writer of books, so that a book configured with michtml gets me without changing its configuration. The plain writer is micbasichtml (MicHTMLVisitor)."

	^ #michtml
]

{ #category : 'visiting - inline elements' }
MicBookHTMLVisitor >> visitAnchorReference: anAnchorReference [
	"Link to the anchor as MicHTMLVisitor does; the text of the link is the number of its target when it has one (Figure *@fb@* reads Figure 2.1), else its label."

	| number |
	number := MicNumberer numberStringOf: anAnchorReference.
	number ifNil: [ ^ super visitAnchorReference: anAnchorReference ].
	canvas tag
		name: 'a';
		parameterAt: 'href' put: (String streamContents: [ :stream |
						 stream
						 << (anAnchorReference propertyAt: #page ifAbsent: [ '' ])
						 << '#' << anAnchorReference bodyString ]);
		with: number
]

{ #category : 'visiting' }
MicBookHTMLVisitor >> visitCode: aCodeBlock [
	"A listing (a code block with a number or a caption) is a code figure, as codeBlock.mustache writes it: the anchor as id of the figure, the code, and a caption starting with Listing and its number when it has one. Other code blocks are written as MicHTMLVisitor does."

	| number figure |
	number := MicNumberer numberStringOf: aCodeBlock.
	(number isNil and: [ aCodeBlock hasCaption not ]) ifTrue: [
		^ super visitCode: aCodeBlock ].
	canvas newLine.
	figure := canvas tag
		          name: 'figure';
		          parameterAt: 'class' put: 'code';
		          yourself.
	aCodeBlock anchor ifNotNil: [ :anchor |
		figure parameterAt: 'id' put: anchor ].
	figure with: [
			canvas tag
				name: 'pre';
				with: [
						canvas tag
							name: 'code';
							with: [ canvas lines: aCodeBlock body ] ].
			canvas tag
				name: 'figcaption';
				with: [
						number ifNotNil: [ self writeNumber: 'Listing ' , number ].
						self visitAll: aCodeBlock captionElements ] ].
	canvas newLine
]

{ #category : 'templating ping pong' }
MicBookHTMLVisitor >> visitFigCaption: aFigure from: aVisitor [
	"Write the caption of aFigure as MicHTMLVisitor does, starting with Figure and its number when it has one."

	canvas tag
		name: 'figcaption';
		with: [
				(MicNumberer numberStringOf: aFigure) ifNotNil: [ :number |
						self writeNumber: 'Figure ' , number ].
				aVisitor visitChildrenOf: aFigure ]
]

{ #category : 'visiting' }
MicBookHTMLVisitor >> visitHeader: aHeader [
	"Write aHeader as MicHTMLVisitor does, its number first when it has one."

	canvas newLine.
	(self headerTagOf: aHeader) with: [
			(MicNumberer numberStringOf: aHeader) ifNotNil: [ :number |
				self writeNumber: number ].
			self visitChildrenOf: aHeader ]
]

{ #category : 'numbers' }
MicBookHTMLVisitor >> writeNumber: aString [
	"Write aString, a number, in a span of class number (so that a stylesheet can style it), followed by a space."

	canvas tag
		name: 'span';
		parameterAt: 'class' put: 'number';
		with: aString.
	canvas nextPutAll: ' '
]
