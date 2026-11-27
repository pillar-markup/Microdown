"
I resolve the references of a book split into pages: a reference (`*@toto@*`) to an anchor that is in another page is marked with that page, so that the writers link to `chapter-2.html#toto` instead of `#toto`; a reference to a numbered target is also marked with its number, so that the writers can show `Figure 3.1` instead of the label. I am a pass of my own: run me after numbering (`MicNumberer`) and splitting the book (`MicChapterSplitter`), and before writing its pages.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `resolve:` with the pages of the book: pairs page name -> document, such as `'chapter-2.html' -> aChapter`. The client decides the page names.
2. I leave my result on the references: the `#page` and `#number` properties.
3. `MicHTMLVisitor>>visitAnchorReference:` writes `href=""page#label""` when the property is there; `MicTemplatedWriter>>visitAnchorReference:` gives it to `anchorReference.mustache` as `page`.

## Responsibility:

- I know in which page each anchor label is, and which number it stands for (through `MicPageLevelAnchorCollector`).
- I mark the references to an anchor of another page with that page, and the references to a numbered target with its number (in their own page too).
- I leave unmarked the references to an anchor of their own page and to unknown anchors (the book tester reports those).

## Collaborators: 

- `MicPageLevelAnchorCollector`: the labels of each page and their numbers.
- `MicNumberer`: numbers the book before me.
- `MicAnchorReferenceBlock`: the references I mark.
- `MicChapterSplitter`: gives the chapters that become the pages.

## Public API and Key Messages

- `resolve: aCollectionOfPages` mark the references of the pages.
- `pages` the pages I resolved.

## Examples

```
MicPageReferenceResolver exampleOfTwoChapters.
MicPageReferenceResolver scriptReferenceAcrossChapters
```

## Internal Representation

- `targets`: a `Dictionary` from a label to its target, an association page name -> number (nil when the target has no number).
- `currentPage`: the name of the page whose references I visit.
- `pages`: the pages I resolved, pairs page name -> document.

### Implementation Points

- When a label is defined in two pages, the first page wins; the book tester reports duplicated anchors.
- I do not replace references by links (`MicLinkBlock`): links are written with `target=""_blank""`, which would open another chapter in a new tab.
"
Class {
	#name : 'MicPageReferenceResolver',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'currentPage',
		'pages',
		'targets'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicPageReferenceResolver class >> exampleOfTwoChapters [
	"A resolver that resolved a book numbered and split into two chapter pages, chapter-1.html and chapter-2.html: the reference of the first chapter to the anchor of the second one is marked with the page chapter-2.html and the number of the second chapter, #(2)."

	<sampleInstance>
	| book splitter |
	book := Microdown parse: '## First chapter

As said in Chapter *@second@*.

## Second chapter
@second

The end.'.
	MicNumberer new number: book.
	splitter := MicChapterSplitter new
		            split: book;
		            yourself.
	^ self new
		  resolve: (splitter chapters withIndexCollect: [ :each :index |
						   (String streamContents: [ :stream |
								    stream << 'chapter-' << index printString << '.html' ])
						   -> each ]);
		  yourself
]

{ #category : 'script' }
MicPageReferenceResolver class >> scriptReferenceAcrossChapters [
	"Answer the HTML of the first chapter page of exampleOfTwoChapters: its reference to the anchor of the second chapter is written as a link to the page of the second chapter (chapter-2.html#second)."

	<example>
	^ MicHTMLVisitor new
		  visit: self exampleOfTwoChapters pages first value;
		  contents
]

{ #category : 'accessing' }
MicPageReferenceResolver >> pages [

	^ pages
]

{ #category : 'resolving' }
MicPageReferenceResolver >> resolve: aCollectionOfPages [
	"aCollectionOfPages holds pairs page name -> document (e.g. 'chapter-2.html' -> a chapter). Mark each anchor reference with its target: the page of its anchor (#page) when that page is not its own, so the writers link to the right page, and the number its anchor stands for (#number, see MicNumberer) when there is one. References to an unknown anchor stay unmarked."

	| collector |
	pages := aCollectionOfPages.
	collector := MicPageLevelAnchorCollector new.
	targets := Dictionary new.
	aCollectionOfPages do: [ :page |
			collector labelsOf: page value.
			collector labelNumbers keysAndValuesDo: [ :label :number |
				targets at: label ifAbsentPut: [ page key -> number ] ] ].
	aCollectionOfPages do: [ :page |
			currentPage := page key.
			self visit: page value ]
]

{ #category : 'visiting - inline elements' }
MicPageReferenceResolver >> visitAnchorReference: anAnchorReference [
	"Mark anAnchorReference with the page of its anchor when that page is not the current one, and with the number its anchor stands for when it has one; leave it alone when its anchor is unknown."

	targets at: anAnchorReference anchorLabel ifPresent: [ :target |
			target key = currentPage ifFalse: [
				anAnchorReference propertyAt: #page put: target key ].
			target value ifNotNil: [ :number |
				anAnchorReference propertyAt: #number put: number ] ]
]
