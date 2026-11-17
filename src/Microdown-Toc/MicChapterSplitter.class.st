"
I split a book written in Microdown into chapters: a chapter starts at each header of my chapter level (2, that is `##`, by default) or less deep, and goes up to the next one. What comes before the first chapter is the front matter. Each chapter and the front matter are documents of their own (`MicRootBlock`), ready to be written as pages of a web site.

## Life cycle: who creates me and who uses me

1. A client creates me with `new`, optionally sets `chapterLevel:` (e.g. 1 when chapters are `#`), and sends me `split:` with the book, usually its `index.md` with the chapter files inlined (`inlineInputFiles`).
2. It then reads `frontMatter` and `chapters`, for example to write the home page and one page per chapter.
3. I'm meant to be used by the Pillar HTML book output; for now only my tests and examples use me.

## Responsibility:

- I cut a book at its chapter headers, keeping each element with the chapter it belongs to (deeper headers, text, code, figures...).
- I go through the files inlined in the book (secondary roots) as if their elements were in the book itself.
- I leave the headers inside other elements (an environment, a quote) where they are: only the headers at the top of the book or of an inlined file start chapters.

## Collaborators: 

- `MicrodownVisitor`: I visit only the roots, the inlined files and the headers; I add the other elements whole, without visiting their contents.
- `MicRootBlock`: the front matter and each chapter.
- `MicHeaderBlock`: its level decides whether it starts a chapter.

## Public API and Key Messages

- `chapterLevel: anInteger` the level of the chapter headers (2 by default).
- `split: aDocument` split aDocument.
- `chapters` the chapters, in order, each starting with its header.
- `frontMatter` what comes before the first chapter.

## Examples

```
MicChapterSplitter exampleOfABook chapters
```

## Internal Representation

- `chapterLevel`: the level of the chapter headers.
- `frontMatter`: a `MicRootBlock`.
- `chapters`: an `OrderedCollection` of `MicRootBlock`.
- `current`: the document receiving the elements while I split.

### Implementation Points

- The elements move to the chapters (their parent becomes the chapter): split a document you will not write as a whole afterwards.
- A header less deep than the chapter level (e.g. a `#` part title when chapters are `##`) also starts a chapter.
"
Class {
	#name : 'MicChapterSplitter',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'chapterLevel',
		'frontMatter',
		'chapters',
		'current'
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
MicChapterSplitter >> chapterLevel [

	^ chapterLevel
]

{ #category : 'accessing' }
MicChapterSplitter >> chapterLevel: anInteger [

	chapterLevel := anInteger
]

{ #category : 'accessing' }
MicChapterSplitter >> chapters [

	^ chapters
]

{ #category : 'accessing' }
MicChapterSplitter >> frontMatter [

	^ frontMatter
]

{ #category : 'initialization' }
MicChapterSplitter >> initialize [

	super initialize.
	chapterLevel := 2
]

{ #category : 'splitting' }
MicChapterSplitter >> split: aDocument [
	"Split aDocument into its front matter and its chapters. A chapter starts at each header of my chapter level or less deep, and goes up to the next one. The files inlined in aDocument are split the same way."

	frontMatter := MicRootBlock new.
	chapters := OrderedCollection new.
	current := frontMatter.
	self visit: aDocument
]

{ #category : 'splitting' }
MicChapterSplitter >> startChapter [
	"The elements that follow go into a new chapter."

	current := MicRootBlock new.
	chapters add: current
]

{ #category : 'visiting' }
MicChapterSplitter >> visitHeader: aHeader [
	"A header of my chapter level, or less deep, starts a new chapter; any header then goes into the current chapter (the new one, or the one it belongs to)."

	aHeader level <= chapterLevel ifTrue: [ self startChapter ].
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
