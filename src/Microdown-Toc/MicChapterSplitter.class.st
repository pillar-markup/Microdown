"
I split a book written in Microdown into chapters: a chapter starts at each chapter or part header of the book (see `MicBookStructure`: `##` and `#` by default), and goes up to the next one. What comes before the first chapter is the front matter. Each chapter and the front matter are documents of their own (`MicRootBlock`), ready to be written as pages of a web site.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `split:` with the book, whose structure (`bookStructure`) says which headers are chapters, usually its `index.md` with the chapter files inlined (`inlineInputFiles`).
2. It then reads `frontMatter` and `chapters`, for example to write the home page and one page per chapter.
3. `PRHtmlBookDocument>>pagesOf:` (Pillar, `pillar build site`) uses me to make the pages of a site.

## Responsibility:

- I cut a book at its chapter headers, keeping each element with the chapter it belongs to (deeper headers, text, code, figures...).
- I go through the files inlined in the book (secondary roots) as if their elements were in the book itself.
- I leave the headers inside other elements (an environment, a quote) where they are: only the headers at the top of the book or of an inlined file start chapters.

## Collaborators: 

- `MicrodownVisitor`: I visit only the roots, the inlined files and the headers; I add the other elements whole, without visiting their contents.
- `MicRootBlock`: the front matter and each chapter.
- `MicBookStructure`: the structure of the book decides which headers start a chapter; I give it to the front matter and to each chapter, so that the writers of their pages follow it.

## Public API and Key Messages

- `split: aDocument` split aDocument.
- `chapters` the chapters, in order, each starting with its header.
- `frontMatter` what comes before the first chapter.

## Examples

```
MicChapterSplitter exampleOfABook chapters
```

## Internal Representation

- `structure`: the structure of the book I split (a `MicBookStructure`).
- `frontMatter`: a `MicRootBlock`.
- `chapters`: an `OrderedCollection` of `MicRootBlock`.
- `current`: the document receiving the elements while I split.

### Implementation Points

- The elements move to the chapters (their parent becomes the chapter): split a document you will not write as a whole afterwards.
- A part header (e.g. a `#` part title when chapters are `##`) also starts a chapter: its page holds its title and the text before its first chapter.
"
Class {
	#name : 'MicChapterSplitter',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'frontMatter',
		'chapters',
		'current',
		'structure'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicChapterSplitter class >> exampleOfABook [
	"A splitter that split a small book: an introduction, then two chapters, the first with a section."

	<sampleInstance>
	^ self new
		  split: (Microdown parse: 'An introduction to the book.

## First chapter

Some text.

### A section

More text.

## Second chapter

The end.');
		  yourself
]

{ #category : 'accessing' }
MicChapterSplitter >> chapters [

	^ chapters
]

{ #category : 'accessing' }
MicChapterSplitter >> frontMatter [

	^ frontMatter
]

{ #category : 'splitting' }
MicChapterSplitter >> newPart [
	"Answer a new document for the front matter or a chapter, with the structure of the book."

	^ MicRootBlock new
		  bookStructure: structure;
		  yourself
]

{ #category : 'splitting' }
MicChapterSplitter >> split: aDocument [
	"Split aDocument into its front matter and its chapters, following the structure of the book (see MicBookStructure): a chapter starts at each chapter or part header, and goes up to the next one. The files inlined in aDocument are split the same way. The front matter and the chapters keep the structure of the book."

	structure := aDocument bookStructure.
	frontMatter := self newPart.
	chapters := OrderedCollection new.
	current := frontMatter.
	self visit: aDocument
]

{ #category : 'splitting' }
MicChapterSplitter >> startChapter [
	"The elements that follow go into a new chapter."

	current := self newPart.
	chapters add: current
]

{ #category : 'accessing' }
MicChapterSplitter >> structure [

^ structure
]

{ #category : 'accessing' }
MicChapterSplitter >> structure: anObject [

structure := anObject
]

{ #category : 'visiting' }
MicChapterSplitter >> visitHeader: aHeader [
	"A chapter header, or a part header, starts a new chapter; any header then goes into the current chapter (the new one, or the one it belongs to)."

	((structure isChapter: aHeader) or: [ structure isPart: aHeader ])
		ifTrue: [ self startChapter ].
	current addChild: aHeader
]

{ #category : 'visiting' }
MicChapterSplitter >> visitRoot: aRoot [
	"Visit the headers and the inlined files (secondary roots come here too); add the other elements, whole, to the current chapter."

	aRoot children do: [ :each |
			(each isHeader or: [ each isSecondaryRoot ])
				ifTrue: [ each accept: self ]
				ifFalse: [ current addChild: each ] ]
]
