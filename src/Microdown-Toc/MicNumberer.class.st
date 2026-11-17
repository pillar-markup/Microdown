"
I number the chapters and sections of a book, the way readers see them: the third chapter is 3, its second section 3.2, the first subsection of that section 3.2.1. I am a pass of my own: I leave the number of each header in its `#number` property, as an Array of integers (`#(3 2)`), and the writers show it in the form they choose.

## Life cycle: who creates me and who uses me

1. The program that publishes a book creates me (`new`, or with `chapterLevel:` when chapters are not `##`), after `MicHeaderIdentifier` and before `MicChapterSplitter`, so that numbers run over the whole book.
2. It sends me `number:` with the whole book (`index.md` with its input files inlined); I visit it once.
3. The writers and the later passes read the `#number` of the headers.

## Responsibility:

- Headers of my chapter level, or less deep, are chapters: 1, 2, 3, in book order. Deeper headers are sections of the current chapter, numbered at their depth below it, the deeper counters restarting at each section; a skipped level counts 0 (`#(1 0 1)`).
- Headers before the first chapter (the front matter) and headers inside another element (an environment) get no number, as `MicChapterSplitter` does not make them chapters.
- Numbers are not link targets: ids stay those of `MicHeaderIdentifier`, made from the text, so links survive when chapters move.

## Collaborators: 

- `MicHeaderBlock`: I set its `#number`.
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
- `document`: the last document I numbered (see `document`).

### Implementation Points

- Only headers for now; figures, code blocks and math blocks will be numbered per chapter by the same pass (see the plan in the step log).
"
Class {
	#name : 'MicNumberer',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'chapterLevel',
		'chapter',
		'sectionCounters',
		'document'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicNumberer class >> exampleOfABook [
	"A numberer that numbered a small book: a foreword (no number), chapter 1 with sections 1.1 and 1.2, and chapter 2 with section 2.1."

	<sampleInstance>
	^ self new
		  number: (Microdown parse: '### Foreword

## First chapter

### Text

### Figures

## Second chapter

### Math');
		  yourself
]

{ #category : 'script' }
MicNumberer class >> scriptNumbersOfABook [
	"Answer the text and number of each header of the book of exampleOfABook: Foreword has none, then First chapter #(1), Text #(1 1), Figures #(1 2), Second chapter #(2), Math #(2 1)."

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
	sectionCounters := OrderedCollection new
]

{ #category : 'numbering' }
MicNumberer >> number: aDocument [
	"Give a #number to the chapters and sections of aDocument, a whole book (its input files inlined): an Array such as #(3 2) for the second section of the third chapter. Headers before the first chapter get none."

	document := aDocument.
	chapter := 0.
	sectionCounters := OrderedCollection new.
	self visit: aDocument
]

{ #category : 'numbering' }
MicNumberer >> numberHeader: aHeader [
	"A header of my chapter level, or less deep, starts the next chapter; a deeper one is a section of the current chapter, numbered at its depth below the chapter, with the deeper counters reset."

	| depth |
	depth := aHeader level - chapterLevel.
	depth <= 0 ifTrue: [
			chapter := chapter + 1.
			sectionCounters := OrderedCollection new.
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
MicNumberer >> visitRoot: aRoot [
	"Number the headers that are children of the book or of its inlined files (secondary roots come back here), and visit the other elements. A header inside another element (e.g. an environment) is not a chapter or a section, as for MicChapterSplitter, so it gets no number."

	aRoot children do: [ :each |
			each isHeader
				ifTrue: [ self numberHeader: each ]
				ifFalse: [ each accept: self ] ]
]
