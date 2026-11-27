"
I describe the structure of a book with two header levels: the level of its chapters and the level from which headers are paragraph labels. Everything else follows: a header less deep than the chapters is a part, the levels between are sections, subsections and subsubsections. The default (`##` chapters, `#####` and deeper paragraphs) suits most books; a book written with `#` chapters declares `""chapterLevel"" : 1` in its `pillar.conf`. The Pillar PDF keeps its own default paragraph level (four levels below the chapters, `######`), so that existing PDFs do not change (`PRPDFDocument>>defaultParagraphLevelFor:`), and `MicLaTeXWriter` does the same for a document without attached structure (`defaultBookStructure`).

## Life cycle: who creates me and who uses me

1. `MicAbstractBlock>>bookStructure` answers the structure attached to the book of a block (`attachedBookStructure`, kept by its `MicRootBlock`), else a new default one (`new`), so that every book has a structure, also a lone Microdown file opened in a checker.
2. Pillar creates me from `pillar.conf` (`PRAbstractOutputDocument>>bookStructure`, with `chapterLevel:paragraphLevel:`) and attaches me to the parsed book (`PRAbstractOutputDocument>>parsedDocumentOf:`, with `MicRootBlock>>bookStructure:`) for every output: PDF, HTML and site. An invalid pair of levels stops the build with my error.
3. The passes and writers of the site and the PDF, and the checkers, are meant to ask the book for me instead of keeping their own levels (steps 3 to 5 of the plan).

## Responsibility:

- I know the chapter level and the paragraph level of a book, and refuse levels that cannot describe a book (`MicInvalidBookStructure`).
- I tell the role of a header: part, chapter, section or paragraph, and how deep a section is below its chapter.
- I tell which headers are numbered (chapters and sections: 2, 2.1) and which are listed in the table of contents (parts, chapters, sections), as the PDF does with sbabook.

## Collaborators: 

- `MicHeaderBlock`: I read its `level`.
- `MicRootBlock`: carries me in its `#bookStructure` property.
- `MicInvalidBookStructure`: signaled by `chapterLevel:paragraphLevel:`.

## Public API and Key Messages

- `MicBookStructure new` (the default), `MicBookStructure chapterLevel: 1` (paragraphs three levels below chapters) and `MicBookStructure chapterLevel: 1 paragraphLevel: 4`
- `roleOfLevel: anInteger` answers `#part`, `#chapter`, `#section` or `#paragraph`; `roleOf: aHeader` and the predicates `isPart:`, `isChapter:`, `isSection:`, `isParagraph:` ask it for a header
- `sectionDepthOfLevel: anInteger`, `sectionDepthOf: aHeader` (1 for a section, 2 for a subsection)
- `isNumberedLevel:`, `isNumbered: aHeader`, `isInTocLevel:`, `isInToc: aHeader`
- `chapterLevel`, `paragraphLevel`

## Examples

```
MicBookStructure exampleDefault.
MicBookStructure exampleChaptersAtLevelOne
```

## Internal Representation

- `chapterLevel`: the level of the chapter headers (2 by default).
- `paragraphLevel`: the level from which headers are paragraph labels (5 by default); every deeper header is a paragraph too.

"
Class {
	#name : 'MicBookStructure',
	#superclass : 'Object',
	#instVars : [
		'chapterLevel',
		'paragraphLevel'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'instance creation' }
MicBookStructure class >> chapterLevel: aChapterLevel [
	"Answer the structure of a book whose chapters are headers of aChapterLevel, with paragraph labels three levels below them, as in the default structure (## chapters, ##### paragraphs)."

	^ self chapterLevel: aChapterLevel paragraphLevel: aChapterLevel + 3
]

{ #category : 'instance creation' }
MicBookStructure class >> chapterLevel: aChapterLevel paragraphLevel: aParagraphLevel [
	"Answer the structure of a book whose chapters are headers of aChapterLevel and whose headers of aParagraphLevel or deeper are paragraph labels. Signal MicInvalidBookStructure when they cannot describe a book."

	| levels |
	levels := {
		          aChapterLevel.
		          aParagraphLevel.
		          (aParagraphLevel - aChapterLevel - 1) }.
	aChapterLevel < 1 ifTrue: [
			MicInvalidBookStructure signal:
				('chapterLevel {1} must be 1 or more' format: levels) ].
	aParagraphLevel <= aChapterLevel ifTrue: [
			MicInvalidBookStructure signal:
				('paragraphLevel {2} must be deeper than chapterLevel {1}'
					 format: levels) ].
	aParagraphLevel > 6 ifTrue: [
			MicInvalidBookStructure signal:
				('paragraphLevel {2} must be 6 or less: headers stop at ######'
					 format: levels) ].
	aParagraphLevel - aChapterLevel > 4 ifTrue: [
			MicInvalidBookStructure signal:
				('paragraphLevel {2} leaves {3} section levels below chapters at level {1}; LaTeX has 3 (section, subsection, subsubsection)'
					 format: levels) ].
	^ self new
		  setChapterLevel: aChapterLevel
		  paragraphLevel: aParagraphLevel
]

{ #category : 'examples' }
MicBookStructure class >> exampleChaptersAtLevelOne [
	"The structure of a book written with # chapters, as its pillar.conf declares it with chapterLevel 1 and paragraphLevel 4."

	<sampleInstance>
	^ self chapterLevel: 1 paragraphLevel: 4
]

{ #category : 'examples' }
MicBookStructure class >> exampleDefault [
	"The structure of a book that declares nothing: # part, ## chapter, ### section, #### subsection, ##### and deeper paragraph."

	<sampleInstance>
	^ self new
]

{ #category : 'accessing' }
MicBookStructure >> chapterLevel [

	^ chapterLevel
]

{ #category : 'initialization' }
MicBookStructure >> initialize [

	super initialize.
	chapterLevel := 2.
	paragraphLevel := 5
]

{ #category : 'roles' }
MicBookStructure >> isChapter: aHeader [

	^ (self roleOf: aHeader) = #chapter
]

{ #category : 'numbers and toc' }
MicBookStructure >> isInToc: aHeader [
	"See isInTocLevel:."

	^ self isInTocLevel: aHeader level
]

{ #category : 'numbers and toc' }
MicBookStructure >> isInTocLevel: anInteger [
	"Parts, chapters and sections are listed in the table of contents, as in the PDF (sbabook lists down to sections)."

	^ (self roleOfLevel: anInteger) = #part or: [
		  self isNumberedLevel: anInteger ]
]

{ #category : 'numbers and toc' }
MicBookStructure >> isNumbered: aHeader [
	"See isNumberedLevel:."

	^ self isNumberedLevel: aHeader level
]

{ #category : 'numbers and toc' }
MicBookStructure >> isNumberedLevel: anInteger [
	"Chapters and sections get a number (2, 2.1), as in the PDF (sbabook numbers down to sections); parts, subsections and deeper do not."

	| role |
	role := self roleOfLevel: anInteger.
	^ role = #chapter or: [
		  role = #section and: [ (self sectionDepthOfLevel: anInteger) = 1 ] ]
]

{ #category : 'roles' }
MicBookStructure >> isParagraph: aHeader [

	^ (self roleOf: aHeader) = #paragraph
]

{ #category : 'roles' }
MicBookStructure >> isPart: aHeader [

	^ (self roleOf: aHeader) = #part
]

{ #category : 'roles' }
MicBookStructure >> isSection: aHeader [

	^ (self roleOf: aHeader) = #section
]

{ #category : 'accessing' }
MicBookStructure >> paragraphLevel [

	^ paragraphLevel
]

{ #category : 'roles' }
MicBookStructure >> roleOf: aHeader [
	"Answer what aHeader is in the book (see roleOfLevel:)."

	^ self roleOfLevel: aHeader level
]

{ #category : 'roles' }
MicBookStructure >> roleOfLevel: anInteger [
	"Answer what a header of level anInteger is in the book: #part, #chapter, #section (sections, subsections and subsubsections) or #paragraph (a paragraph label, at my paragraph level or deeper)."

	anInteger < chapterLevel ifTrue: [ ^ #part ].
	anInteger = chapterLevel ifTrue: [ ^ #chapter ].
	anInteger < paragraphLevel ifTrue: [ ^ #section ].
	^ #paragraph
]

{ #category : 'roles' }
MicBookStructure >> sectionDepthOf: aHeader [
	"Answer how deep aHeader is below its chapter (see sectionDepthOfLevel:)."

	^ self sectionDepthOfLevel: aHeader level
]

{ #category : 'roles' }
MicBookStructure >> sectionDepthOfLevel: anInteger [
	"Answer how deep a section of level anInteger is below its chapter: 1 for a section, 2 for a subsection, 3 for a subsubsection."

	^ anInteger - chapterLevel
]

{ #category : 'initialization' }
MicBookStructure >> setChapterLevel: aChapterLevel paragraphLevel: aParagraphLevel [

	chapterLevel := aChapterLevel.
	paragraphLevel := aParagraphLevel
]
