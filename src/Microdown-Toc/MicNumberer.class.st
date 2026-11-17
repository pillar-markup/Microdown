"
I number the chapters, sections, figures, listings and equations of a book, the way readers see them: the third chapter is 3, its second section 3.2, the first subsection of that section 3.2.1, its first figure 3.1. I am a pass of my own: I leave the number of each element in its `#number` property, as an Array of integers (`#(3 2)`), and the writers show it in the form they choose.

## Life cycle: who creates me and who uses me

1. The program that publishes a book creates me (`new`, or with `chapterLevel:` when chapters are not `##`), after `MicHeaderIdentifier` and before `MicChapterSplitter`, so that numbers run over the whole book.
2. It sends me `number:` with the whole book (`index.md` with its input files inlined); I visit it once.
3. The writers and the later passes read the `#number` of the elements.

## Responsibility:

- Headers of my chapter level, or less deep, are chapters: 1, 2, 3, in book order. Deeper headers are sections of the current chapter, numbered at their depth below it, the deeper counters restarting at each section; a skipped level counts 0 (`#(1 0 1)`).
- Headers before the first chapter (the front matter) and headers inside another element (an environment) get no number, as `MicChapterSplitter` does not make them chapters.
- Figures, listings (code blocks) and equations (math blocks) are numbered when they have a caption or an anchor, each kind with its own counter, restarting in each chapter: the first figure of chapter 3 is 3.1, and so is its first listing. Code snippets and math without caption or anchor are not numbered.
- Numbers are not link targets: ids stay those of `MicHeaderIdentifier`, made from the text, so links survive when chapters move.

## Collaborators: 

- `MicHeaderBlock`, `MicFigureBlock`, `MicCodeBlock`, `MicMathBlock`: I set their `#number`.
- `MicChapterSplitter`: we agree on what a chapter is (same `chapterLevel`, headers of the book or of its inlined files only).
- `MicHeaderIdentifier`: runs before me; ids and numbers are kept apart.

## Public API and Key Messages

- `number: aDocument`
- `document` the document I numbered
- `chapterLevel: anInteger` (2 by default: chapters are `##`)

## Examples

```
MicNumberer exampleOfABook.
MicNumberer scriptNumbersOfABook
```

## Internal Representation

- `chapterLevel`: the level of the chapter headers.
- `chapter`: the number of the current chapter, 0 before the first one.
- `sectionCounters`: the counters of the current section at each depth below the chapter.
- `elementCounters`: the counters of the figures, listings and equations of the current chapter, by kind (`#figure`, `#listing`, `#equation`).
- `document`: the last document I numbered (see `document`).

### Implementation Points

- A figure's caption is checked with `captionElements`: `MicFigureBlock>>hasCaption` is true even for an empty caption (Microdown backlog).
- Figures inside environments or lists are numbered: unlike headers, they do not need to be children of the book.
"
Class {
	#name : 'MicNumberer',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'chapterLevel',
		'chapter',
		'sectionCounters',
		'document',
		'elementCounters'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicNumberer class >> exampleOfABook [
	"A numberer that numbered a small book: a foreword (no number), chapter 1 with sections 1.1 (holding figure 1.1) and 1.2 (holding listing 1.1), and chapter 2 with section 2.1 (holding equation 2.1)."

	<sampleInstance>
	^ self new
		  number: (Microdown parse: '### Foreword

## First chapter

### Text

![The Pharo logo.](figures/pharo.png)

### Code

```caption=A first listing
1 + 2
```

## Second chapter

### Math

$$ % anchor=sum
a + b
$$');
		  yourself
]

{ #category : 'script' }
MicNumberer class >> scriptNumbersOfABook [
	"Answer the text and number of each header of the book of exampleOfABook: Foreword has none, then First chapter #(1), Text #(1 1), Code #(1 2), Second chapter #(2), Math #(2 1)."

	<example>
	^ self exampleOfABook document children
		  select: [ :each | each isHeader ]
		  thenCollect: [ :each |
		  each text -> (each propertyAt: #number ifAbsent: [ nil ]) ]
]

{ #category : 'accessing' }
MicNumberer >> chapterLevel [

	^ chapterLevel
]

{ #category : 'accessing' }
MicNumberer >> chapterLevel: anInteger [

	chapterLevel := anInteger
]

{ #category : 'accessing' }
MicNumberer >> document [

	^ document
]

{ #category : 'initialization' }
MicNumberer >> initialize [

	super initialize.
	chapterLevel := 2.
	chapter := 0.
	sectionCounters := OrderedCollection new.
	elementCounters := Dictionary new
]

{ #category : 'numbering' }
MicNumberer >> number: aDocument [
	"Give a #number to the chapters, sections, figures, listings (code blocks) and equations (math blocks) of aDocument, a whole book (its input files inlined): an Array such as #(3 2) for the second section of the third chapter, or for its second figure. Elements before the first chapter get none."

	document := aDocument.
	chapter := 0.
	sectionCounters := OrderedCollection new.
	elementCounters := Dictionary new.
	self visit: aDocument
]

{ #category : 'numbering' }
MicNumberer >> number: anElement in: aKind [
	"Give anElement the next number of aKind (#figure, #listing or #equation) in the current chapter; nothing before the first chapter."

	| count |
	chapter = 0 ifTrue: [ ^ self ].
	count := (elementCounters at: aKind ifAbsent: [ 0 ]) + 1.
	elementCounters at: aKind put: count.
	anElement propertyAt: #number put: {
			chapter.
			count }
]

{ #category : 'numbering' }
MicNumberer >> numberHeader: aHeader [
	"A header of my chapter level, or less deep, starts the next chapter, where figures, listings and equations count from 1 again; a deeper one is a section of the current chapter, numbered at its depth below the chapter, with the deeper counters reset."

	| depth |
	depth := aHeader level - chapterLevel.
	depth <= 0 ifTrue: [
			chapter := chapter + 1.
			sectionCounters := OrderedCollection new.
			elementCounters := Dictionary new.
			^ aHeader propertyAt: #number put: { chapter } ].
	chapter = 0 ifTrue: [ ^ self ].
	[ sectionCounters size < depth ] whileTrue: [ sectionCounters add: 0 ].
	sectionCounters removeLast: sectionCounters size - depth.
	sectionCounters at: depth put: (sectionCounters at: depth) + 1.
	aHeader
		propertyAt: #number
		put: { chapter } , sectionCounters asArray
]

{ #category : 'visiting' }
MicNumberer >> visitCode: aCodeBlock [
	"A code block with a caption or an anchor is a numbered listing; other code blocks are plain snippets."

	(aCodeBlock hasCaption or: [ aCodeBlock hasAnchor ]) ifTrue: [
		self number: aCodeBlock in: #listing ]
]

{ #category : 'visiting - inline elements' }
MicNumberer >> visitFigure: aFigure [
	"A figure is numbered when it has a caption or an anchor. Its caption is checked directly: MicFigureBlock>>#hasCaption is true even for an empty caption (see the Microdown backlog)."

	(aFigure captionElements isNotEmpty or: [ aFigure hasAnchor ])
		ifTrue: [ self number: aFigure in: #figure ]
]

{ #category : 'visiting' }
MicNumberer >> visitMath: aMathBlock [
	"A math block with a caption or an anchor is a numbered equation."

	(aMathBlock hasCaption or: [ aMathBlock hasAnchor ]) ifTrue: [
		self number: aMathBlock in: #equation ]
]

{ #category : 'visiting' }
MicNumberer >> visitRoot: aRoot [
	"Number the headers that are children of the book or of its inlined files (secondary roots come back here), and visit the other elements. A header inside another element (e.g. an environment) is not a chapter or a section, as for MicChapterSplitter, so it gets no number."

	aRoot children do: [ :each |
			each isHeader
				ifTrue: [ self numberHeader: each ]
				ifFalse: [ each accept: self ] ]
]
