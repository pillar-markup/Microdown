"
I resolve the references of a book split into pages: a reference (`*@toto@*`) to an anchor that is in another page is marked with that page, so that the writers link to `chapter-2.html#toto` instead of `#toto`. I am a pass of my own: run me after splitting the book (`MicChapterSplitter`) and before writing its pages.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `resolve:` with the pages of the book: pairs page name -> document, such as `'chapter-2.html' -> aChapter`. The client decides the page names.
2. I leave my result on the references: the `#page` property.
3. `MicHTMLVisitor>>visitAnchorReference:` writes `href=""page#label""` when the property is there; `MicTemplatedWriter>>visitAnchorReference:` gives it to `anchorReference.mustache` as `page`.

## Responsibility:

- I know in which page each anchor label is (through `MicPageLevelAnchorCollector`).
- I mark the references to an anchor of another page with that page.
- I leave unmarked the references to an anchor of their own page and to unknown anchors (the book tester reports those).

## Collaborators: 

- `MicPageLevelAnchorCollector`: the labels of each page.
- `MicAnchorReferenceBlock`: the references I mark.
- `MicChapterSplitter`: gives the chapters that become the pages.

## Public API and Key Messages

- `resolve: aCollectionOfPages` mark the references of the pages.

## Examples

```
MicPageReferenceResolver scriptReferenceAcrossChapters
```

## Internal Representation

- `pageOfLabels`: a `Dictionary` from a label to the name of its page.
- `currentPage`: the name of the page whose references I visit.

### Implementation Points

- When a label is defined in two pages, the first page wins; the book tester reports duplicated anchors.
- I do not replace references by links (`MicLinkBlock`): links are written with `target=""_blank""`, which would open another chapter in a new tab.
"
Class {
	#name : 'MicPageReferenceResolver',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'pageOfLabels',
		'currentPage'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'script' }
MicPageReferenceResolver class >> scriptReferenceAcrossChapters [
	"A book split into two chapter pages: the reference of the first chapter to the anchor of the second one is written as a link to the page of the second chapter (chapter-2.html#second). Answer the HTML of the first chapter."

	<example>
	| splitter pages |
	splitter := MicChapterSplitter new
		            split: (Microdown parse: '## First chapter

As said in *@second@*.

## Second chapter
@second

The end.');
		            yourself.
	pages := splitter chapters withIndexCollect: [ :each :index |
			         (String streamContents: [ :stream |
				          stream << 'chapter-' << index printString << '.html' ])
			         -> each ].
	self new resolve: pages.
	^ MicHTMLVisitor new
		  visit: splitter chapters first;
		  contents
]

{ #category : 'resolving' }
MicPageReferenceResolver >> resolve: aCollectionOfPages [
	"aCollectionOfPages holds pairs page name -> document (e.g. 'chapter-2.html' -> a chapter). Mark each anchor reference whose anchor is in another page with that page (its #page property), so the writers link to the right page. References to an anchor of their own page, or to an unknown anchor, stay unmarked."

	| collector |
	collector := MicPageLevelAnchorCollector new.
	pageOfLabels := Dictionary new.
	aCollectionOfPages do: [ :page |
			(collector labelsOf: page value) do: [ :label |
				pageOfLabels at: label ifAbsentPut: [ page key ] ] ].
	aCollectionOfPages do: [ :page |
			currentPage := page key.
			self visit: page value ]
]

{ #category : 'visiting - inline elements' }
MicPageReferenceResolver >> visitAnchorReference: anAnchorReference [
	"Mark anAnchorReference with the page of its anchor when that page is not the current one; leave it alone when its anchor is in the current page or unknown."

	pageOfLabels at: anAnchorReference anchorLabel ifPresent: [ :page |
			page = currentPage ifFalse: [
				anAnchorReference propertyAt: #page put: page ] ]
]
