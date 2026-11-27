"
I replace the PDF figures of a document by the PNG files that sit next to them, because a browser does not display a PDF in an `img` element. A book keeps `![A diagram.](figures/x.pdf)` in its text so that its LaTeX output stays vectorial; when `figures/x.png` exists, the HTML site shows that file instead.

## Life cycle: who creates me and who uses me

1. `PRHtmlBookDocument>>pagesOf:` creates me, first among the passes run on the book, before `MicPathRelativizer`: the references are still absolute, so I can check that the PNG file exists.
2. It sends me `substitute:` with the book; I visit it and change the references of its figures in place.
3. `MicPathRelativizer` then makes the new references relative to the book folder.

## Responsibility:

- I replace the absolute file reference of a figure whose file ends with `.pdf` by a reference to the file with the same name and the extension `png`, when that file exists.
- I leave alone a PDF figure without a PNG next to it (the site shows a broken image, as before), the other figures, the web figures and the relative references (a document not loaded from a file).
- I do not create PNG files: the book does (for example with `pdftocairo -png -singlefile -r 150 x.pdf x`).
- I am a pass of my own, like `MicPathRelativizer` or `MicHeaderIdentifier`: one job, one visit.

## Collaborators: 

- `MicFigureBlock`: I read and replace its `reference`.
- `MicFileResourceReference`: gives the file of an absolute reference (`fileReference`).
- `MicPathRelativizer`: runs after me.

## Public API and Key Messages

- `substitute: aDocument`
- `document` the document I worked on

## Examples

```
MicWebFigureSubstituter exampleOfABook
```

## Internal Representation

- `document`: the last document I worked on.
"
Class {
	#name : 'MicWebFigureSubstituter',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'document'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicWebFigureSubstituter class >> exampleOfABook [
	"A substituter that worked on a small book in a memory file system, loaded as Pillar does (input files inlined): its chapter has the figure figures/x.pdf and the file figures/x.png next to it, so the figure now refers to x.png."

	<sampleInstance>
	| book |
	book := FileSystem memory / 'book'.
	(book / 'Chapters' / 'figures') ensureCreateDirectory.
	book / 'index.md' writeStreamDo: [ :stream |
		stream nextPutAll: '<!inputFile|path=Chapters/one.md!>' ].
	book / 'Chapters' / 'one.md' writeStreamDo: [ :stream |
		stream nextPutAll: '![A caption.](figures/x.pdf)' ].
	(book / 'Chapters' / 'figures' / 'x.pdf') ensureCreateFile.
	(book / 'Chapters' / 'figures' / 'x.png') ensureCreateFile.
	^ self new
		  substitute:
			  (book / 'index.md') asMicResourceReference loadMicrodown
				  inlineInputFiles;
		  yourself
]

{ #category : 'accessing' }
MicWebFigureSubstituter >> document [

	^ document
]

{ #category : 'visiting' }
MicWebFigureSubstituter >> substitute: aDocument [
	"Replace in aDocument the PDF figures that have a PNG file next to them by that PNG file."

	document := aDocument.
	self visit: aDocument
]

{ #category : 'visiting' }
MicWebFigureSubstituter >> visitFigure: aFigure [
	"Give aFigure the PNG file next to its PDF file, when there is one; leave the other figures alone."

	| reference png |
	reference := aFigure reference.
	reference isRelative ifTrue: [ ^ self ].
	reference isMicrodownResourceFileReference ifFalse: [ ^ self ].
	reference fileReference extension asLowercase = 'pdf' ifFalse: [
		^ self ].
	png := reference fileReference withExtension: 'png'.
	png exists ifFalse: [ ^ self ].
	aFigure reference: png asMicResourceReference
]
