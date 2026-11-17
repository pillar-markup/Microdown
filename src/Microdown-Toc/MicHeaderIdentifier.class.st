"
I give each header of a Microdown document its link target, so that a table of contents (and, later, references across pages) can link to it. I am a pass of my own: run me once on a document (a whole book before splitting it), before building its table of contents and before writing it.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `identify:` with a document.
2. I leave my results on the headers: an anchored header gets the `#anchor` property, the others an `#id` property.
3. `MicHTMLVisitor>>headerTagOf:` writes the `#id` of a header as its `id` attribute; `MicTocBuilder>>templateValuesOf:` links each entry to `MicHeaderIdentifier targetOf: aHeader`. `MicBookSitePublisher>>tableOfContentsOf:` runs me before building the table of contents of a chapter.

## Responsibility:

- A header followed by an anchor (`## Chatoto` then `@chatoto`) takes the label of that anchor as link target and gets no id of its own: the anchor is already written as an element with that id, and an HTML page must not have the same id twice.
- The other headers get an id made of the lowercase words of their text joined by dashes (`Text emphasis` gives `text-emphasis`).
- Generated ids are unique in the document and never reuse a label of the document: anchors, and the anchors of figures, code and math blocks (a second `intro` becomes `intro-2`).

## Collaborators: 

- `MicPageLevelAnchorCollector`, my superclass: collects the anchor labels of the document while I collect its headers, before I give any id.
- `MicHeaderBlock`: receives its `#anchor` or `#id` property.
- `MicAnchorBlock`, `MicFigureBlock`, `MicCodeBlock`, `MicMathBlock`: the labels I must not reuse.

## Public API and Key Messages

- `identify: aDocument` give the headers of aDocument their link targets.
- `MicHeaderIdentifier targetOf: aHeader` the link target of an identified header (nil when it was not identified).
- `idFromText: aString` and `uniqueId: anId in: aSet` build the generated ids.

## Examples

```
MicHeaderIdentifier exampleOfAChapter
```

## Internal Representation

- `headers`: the headers of the document, in order.
- `headerLabels`: the anchored headers, an `IdentityDictionary` from a header to the label of its anchor.

### Implementation Points

- An anchor is the anchor of a header when the header is the element right before it in the same parent (blank lines do not count).
- I change the headers (their properties): identify a document once, before writing it.
"
Class {
	#name : 'MicHeaderIdentifier',
	#superclass : 'MicPageLevelAnchorCollector',
	#instVars : [
		'headers',
		'headerLabels'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicHeaderIdentifier class >> exampleOfAChapter [
	"An identifier that identified the headers of a small chapter: the first header has an anchor, the two others get ids, the last one numbered since its text gives the label of a figure anchor."

	<sampleInstance>
	^ self new
		  identify: (Microdown parse: '## Microdown syntax
@syntax

### Figures

![A caption.%anchor=figures](figures/x.png)

### Tables

The end.');
		  yourself
]

{ #category : 'accessing' }
MicHeaderIdentifier class >> targetOf: aHeader [
	"Answer the link target an identified header got: the label of its anchor, else its generated id, else nil when it was not identified."

	^ aHeader
		  propertyAt: #anchor
		  ifAbsent: [ aHeader propertyAt: #id ifAbsent: [ nil ] ]
]

{ #category : 'ids' }
MicHeaderIdentifier >> idFromText: aString [
	"Answer an HTML id made of the lowercase words of aString separated by dashes."

	| words |
	words := (aString asLowercase collect: [ :each |
			          each isAlphaNumeric
				          ifTrue: [ each ]
				          ifFalse: [ Character space ] ]) substrings.
	^ words ifEmpty: [ 'section' ] ifNotEmpty: [ '-' join: words ]
]

{ #category : 'identifying' }
MicHeaderIdentifier >> identify: aDocument [
	"Give each header of aDocument its link target: the label of the anchor that follows it (its #anchor property), or else an id made from its text (its #id property, written by the HTML writers). Generated ids never reuse the label of an anchor of aDocument, nor another generated id."

	| ids |
	headers := OrderedCollection new.
	headerLabels := IdentityDictionary new.
	ids := (self labelsOf: aDocument) copy.
	headers do: [ :each |
			headerLabels
				at: each
				ifPresent: [ :label | each propertyAt: #anchor put: label ]
				ifAbsent: [
						each
							propertyAt: #id
							put: (self uniqueId: (self idFromText: each text) in: ids) ] ]
]

{ #category : 'ids' }
MicHeaderIdentifier >> uniqueId: anId in: aSet [
	"Answer anId, or anId followed by a number when aSet already has it, and add the answer to aSet."

	| id count |
	id := anId.
	count := 1.
	[ aSet includes: id ] whileTrue: [
			count := count + 1.
			id := String streamContents: [ :stream |
				      stream << anId << '-' << count printString ] ].
	aSet add: id.
	^ id
]

{ #category : 'visiting' }
MicHeaderIdentifier >> visitAnchor: anAnchor [
	"Collect the label of anAnchor; when anAnchor comes right after a header, it is the anchor of that header."

	| siblings index |
	super visitAnchor: anAnchor.
	siblings := anAnchor parent children.
	index := siblings identityIndexOf: anAnchor.
	(index > 1 and: [ (siblings at: index - 1) isHeader ]) ifTrue: [
		headerLabels at: (siblings at: index - 1) put: anAnchor label ]
]

{ #category : 'visiting' }
MicHeaderIdentifier >> visitHeader: aHeader [

	headers add: aHeader
]
