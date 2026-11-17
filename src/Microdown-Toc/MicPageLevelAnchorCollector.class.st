"
I collect the anchor labels of a Microdown document, one page at a time: its anchors (`@label`) and the anchors of its figures, code and math blocks (`%anchor=fig1`, `anchor=code1`). These are the labels a reference (`*@label@*`) can point to.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `labelsOf:` with a document; I answer a `Set` of labels. I can be reused for another document.
2. `MicPageReferenceResolver>>resolve:` uses me to know which page holds which label.
3. `MicHeaderIdentifier`, my subclass, uses the labels so that the ids it generates never take the label of an anchor.

## Responsibility:

- I know the labels a document defines, whatever element defines them.
- I visit the whole document, including the files inlined in it and the figures inside paragraphs.
- I ignore the figures, code and math blocks without anchor.

## Collaborators: 

- `MicAnchorBlock`: its `label`.
- `MicFigureBlock`, `MicCodeBlock`, `MicMathBlock`: `hasAnchor` and `anchorLabel`, the protocol `MicReferenceChecker` also uses.

## Public API and Key Messages

- `labelsOf: aDocument` answer the anchor labels of aDocument.
- `anchorLabels` the labels of the last document.

## Examples

```
MicPageLevelAnchorCollector exampleOfAChapter
```

## Internal Representation

- `anchorLabels`: the labels collected for the current document, a `Set`.
"
Class {
	#name : 'MicPageLevelAnchorCollector',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'anchorLabels'
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
	"Collect the anchor label of anElement (a figure, a code or a math block), when it has one."

	anElement hasAnchor ifTrue: [
		anchorLabels add: anElement anchorLabel ]
]

{ #category : 'accessing' }
MicPageLevelAnchorCollector >> anchorLabels [

	^ anchorLabels
]

{ #category : 'collecting' }
MicPageLevelAnchorCollector >> labelsOf: aDocument [
	"Answer the anchor labels of aDocument: its anchors (@label) and the anchors of its figures, code and math blocks."

	anchorLabels := Set new.
	self visit: aDocument.
	^ anchorLabels
]

{ #category : 'visiting' }
MicPageLevelAnchorCollector >> visitAnchor: anAnchor [
	"An anchor (@label) defines its label."

	anchorLabels add: anAnchor label
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
MicPageLevelAnchorCollector >> visitMath: aMath [
	"A math block defines a label when it has an anchor argument (%anchor=eq1)."

	self addAnchorOf: aMath
]
