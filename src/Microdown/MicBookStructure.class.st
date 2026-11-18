"
I describe the structure of a book with two header levels: the level of its chapters and the level from which headers are paragraph labels. Everything else follows: a header less deep than the chapters is a part, the levels between are sections, subsections and subsubsections. The default (`##` chapters, `#####` paragraphs) suits most books; a book written with `#` chapters declares `""chapterLevel"" : 1, ""paragraphLevel"" : 4` in its `pillar.conf`.

## Life cycle: who creates me and who uses me

1. `MicRootBlock>>bookStructure` answers the structure attached to a document, else a new default one (`new`), so that every book has a structure, also a lone Microdown file opened in a checker.
2. Pillar is meant to create me from `pillar.conf` with `chapterLevel:paragraphLevel:` and attach me to the parsed book with `MicRootBlock>>bookStructure:` (step 2 of `BookStructure-plan.md`; not done yet).
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

- `MicBookStructure new` (the default) and `MicBookStructure chapterLevel: 1 paragraphLevel: 4`
- `roleOf: aHeader` answers `#part`, `#chapter`, `#section` or `#paragraph`; `isPart:`, `isChapter:`, `isSection:`, `isParagraph:`
- `sectionDepthOf: aHeader` (1 for a section, 2 for a subsection)
- `isNumbered: aHeader`, `isInToc: aHeader`
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
	"Parts, chapters and sections are listed in the table of contents, as in the PDF (sbabook lists down to sections)."

	^ (self isPart: aHeader) or: [ self isNumbered: aHeader ]
]

{ #category : 'numbers and toc' }
MicBookStructure >> isNumbered: aHeader [
	"Chapters and sections get a number (2, 2.1), as in the PDF (sbabook numbers down to sections); parts, subsections and deeper do not."

	^ (self isChapter: aHeader) or: [
		  (self isSection: aHeader) and: [
			  (self sectionDepthOf: aHeader) = 1 ] ]
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
	"Answer what aHeader is in the book: #part, #chapter, #section (sections, subsections and subsubsections) or #paragraph (a paragraph label, at my paragraph level or deeper)."

	aHeader level < chapterLevel ifTrue: [ ^ #part ].
	aHeader level = chapterLevel ifTrue: [ ^ #chapter ].
	aHeader level < paragraphLevel ifTrue: [ ^ #section ].
	^ #paragraph
]

{ #category : 'roles' }
MicBookStructure >> sectionDepthOf: aHeader [
	"Answer how deep aHeader is below its chapter: 1 for a section, 2 for a subsection, 3 for a subsubsection."

	^ aHeader level - chapterLevel
]

{ #category : 'initialization' }
MicBookStructure >> setChapterLevel: aChapterLevel paragraphLevel: aParagraphLevel [

	chapterLevel := aChapterLevel.
	paragraphLevel := aParagraphLevel
]
