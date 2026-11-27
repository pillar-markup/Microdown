"
I collect the anchor labels of a Microdown document, one page at a time: its anchors (`@label`) and the anchors of its figures, code and math blocks (`%anchor=fig1`, `anchor=code1`). These are the labels a reference (`*@label@*`) can point to. I also record the number each label stands for, when the document was numbered (`MicNumberer`).

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `labelsOf:` with a document; I answer a `Set` of labels. I can be reused for another document.
2. `MicPageReferenceResolver>>resolve:` uses me to know which page holds which label, and which number it stands for.
3. `MicHeaderIdentifier`, my subclass, uses the labels so that the ids it generates never take the label of an anchor.

## Responsibility:

- I know the labels a document defines, whatever element defines them.
- I visit the whole document, including the files inlined in it and the figures inside paragraphs.
- I ignore the figures, code and math blocks without anchor.
- A figure, code or math label stands for the `#number` of its element; an anchor (`@label`) stands for the number of the section it is in, which is the header right above it when there is one; nil when there is no number.

## Collaborators: 

- `MicAnchorBlock`: its `label`.
- `MicHeaderBlock`: its `#number`, the section of the anchors that follow it.
- `MicFigureBlock`, `MicCodeBlock`, `MicMathBlock`: `hasAnchor` and `anchorLabel`, the protocol `MicReferenceChecker` also uses.

## Public API and Key Messages

- `labelsOf: aDocument` answer the anchor labels of aDocument.
- `anchorLabels` the labels of the last document.
- `labelNumbers` the labels of the last document with the number each stands for.

## Examples

```
MicPageLevelAnchorCollector exampleOfAChapter
```

## Internal Representation

- `labelNumbers`: a `Dictionary` from each label of the current document to the number it stands for (an Array such as `#(3 1)`, or nil). When a label is defined twice, the first one wins.
- `sectionNumber`: the number of the last numbered header visited.
"
Class {
	#name : 'MicPageLevelAnchorCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'sectionNumber',
		'labelNumbers'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicPageLevelAnchorCollector class >> exampleOfAChapter [
	"A collector that collected the anchor labels of a small chapter: a section anchor, a figure and a code block."

	<sampleInstance>
	^ self new
		  labelsOf: (Microdown parse: '## Toto
@toto

![A caption.%anchor=fig1](figures/x.png)

```anchor=code1
foo
```');
		  yourself
]

{ #category : 'collecting' }
MicPageLevelAnchorCollector >> addAnchorOf: anElement [
	"Collect the anchor label of anElement (a figure, a code or a math block), when it has one; it stands for the number of anElement."

	anElement hasAnchor ifTrue: [
			labelNumbers
				at: anElement anchorLabel
				ifAbsentPut: [ anElement propertyAt: #number ifAbsent: [ nil ] ] ]
]

{ #category : 'accessing' }
MicPageLevelAnchorCollector >> anchorLabels [

	^ labelNumbers keys asSet
]

{ #category : 'accessing' }
MicPageLevelAnchorCollector >> labelNumbers [

	^ labelNumbers
]

{ #category : 'collecting' }
MicPageLevelAnchorCollector >> labelsOf: aDocument [
	"Answer the anchor labels of aDocument: its anchors (@label) and the anchors of its figures, code and math blocks. Also record the number each label stands for (see labelNumbers)."

	labelNumbers := Dictionary new.
	sectionNumber := nil.
	self visit: aDocument.
	^ labelNumbers keys asSet
]

{ #category : 'visiting' }
MicPageLevelAnchorCollector >> visitAnchor: anAnchor [
	"An anchor (@label) defines its label; it stands for the number of the section it is in, which is the number of the header right above it when there is one."

	labelNumbers at: anAnchor label ifAbsentPut: [ sectionNumber ]
]

{ #category : 'visiting' }
MicPageLevelAnchorCollector >> visitCode: aCode [
	"A code block defines a label when it has an anchor argument (anchor=code1)."

	self addAnchorOf: aCode
]

{ #category : 'visiting - inline elements' }
MicPageLevelAnchorCollector >> visitFigure: aFigure [
	"A figure defines a label when it has an anchor argument (%anchor=fig1)."

	self addAnchorOf: aFigure
]

{ #category : 'visiting' }
MicPageLevelAnchorCollector >> visitHeader: aHeader [
	"A numbered header starts the section the following anchors stand for; an unnumbered one (e.g. in an environment) leaves the current section."

	sectionNumber := aHeader
		                 propertyAt: #number
		                 ifAbsent: [ sectionNumber ].
	super visitHeader: aHeader
]

{ #category : 'visiting' }
MicPageLevelAnchorCollector >> visitMath: aMath [
	"A math block defines a label when it has an anchor argument (%anchor=eq1)."

	self addAnchorOf: aMath
]
