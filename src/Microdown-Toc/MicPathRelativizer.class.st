"
I make the figure references of a document relative to a directory, usually the folder of a book. I am the reverse of `MicZincPathResolver`: when a book is loaded, it resolves the figures of each file against that file, so a figure of `Chapters/Chapter1/chapter1.md` refers to `/Users/.../Chapters/Chapter1/figures/x.png`; once the book is written as a site whose pages sit at the top of a copy of the book folder, the figure must be `Chapters/Chapter1/figures/x.png`.

## Life cycle: who creates me and who uses me

1. `PRHtmlBookDocument>>pagesOf:` creates me, first among the passes run on the book (`index.md` with its input files inlined).
2. It sends me `relativize:to:` with the book and the folder of the project; I visit the book and change the references of its figures in place.
3. The writer (e.g. `MicHTMLVisitor`) then writes the path of each reference, which is now relative.

## Responsibility:

- I replace the absolute file reference of a figure stored in my base directory by a `MicRelativeResourceReference` to the same file, relative to that directory.
- I leave alone the figures that are already relative (a document not loaded from a file), web figures, and files outside the base directory (they would not be in the site).
- I am a pass of my own, like `MicHeaderIdentifier` or `MicPageReferenceResolver`: one job, one visit.

## Collaborators: 

- `MicFigureBlock`: I read and replace its `reference`.
- `MicFileResourceReference`: gives the file of an absolute reference (`fileReference`).
- `MicZincPathResolver`: does the reverse when a document is loaded.

## Public API and Key Messages

- `relativize: aDocument to: aDirectory`
- `document` the document I relativized

## Examples

```
MicPathRelativizer exampleOfABook.
MicPathRelativizer scriptFigureOfAChapter
```

## Internal Representation

- `baseDirectory`: the directory the references become relative to.
- `document`: the last document I relativized.

### Implementation Points

- Only figures for now; links to local files (`[code](files/x.st)`) could be relativized the same way.
- A relative reference is written with its path by `MicHTMLVisitor>>visitImg:from:`; a web figure is still written badly by it (only `/x.png`, see the Microdown backlog).
"
Class {
	#name : 'MicPathRelativizer',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'baseDirectory',
		'document'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'examples' }
MicPathRelativizer class >> exampleOfABook [
	"A relativizer that relativized a small book in a memory file system, loaded as Pillar does (input files inlined): the figure of its chapter file, absolute after loading, refers to Chapters/figures/x.png."

	<sampleInstance>
	| book |
	book := FileSystem memory / 'book'.
	(book / 'Chapters') ensureCreateDirectory.
	book / 'index.md' writeStreamDo: [ :stream |
		stream nextPutAll: '<!inputFile|path=Chapters/one.md!>' ].
	book / 'Chapters' / 'one.md' writeStreamDo: [ :stream |
		stream nextPutAll: '![A caption.](figures/x.png)' ].
	^ self new
		  relativize:
			  (book / 'index.md') asMicResourceReference loadMicrodown
				  inlineInputFiles
		  to: book;
		  yourself
]

{ #category : 'script' }
MicPathRelativizer class >> scriptFigureOfAChapter [
	"Answer the HTML of the book of exampleOfABook: the figure source is Chapters/figures/x.png, relative to the book folder, instead of its absolute path."

	<example>
	^ MicHTMLVisitor new
		  visit: self exampleOfABook document;
		  contents
]

{ #category : 'accessing' }
MicPathRelativizer >> document [

	^ document
]

{ #category : 'relativizing' }
MicPathRelativizer >> relativize: aDocument to: aDirectory [
	"Replace in aDocument the absolute references of the figures stored in aDirectory by references relative to aDirectory."

	document := aDocument.
	baseDirectory := aDirectory.
	self visit: aDocument
]

{ #category : 'visiting - inline elements' }
MicPathRelativizer >> visitFigure: aFigure [
	"Give aFigure a reference relative to my base directory when it refers to a file stored there; leave relative, web and outside references alone."

	| reference |
	reference := aFigure reference.
	reference isRelative ifTrue: [ ^ self ].
	reference isMicrodownResourceFileReference ifFalse: [ ^ self ].
	(reference fileReference isContainedBy: baseDirectory) ifFalse: [
		^ self ].
	aFigure reference:
		(reference fileReference relativeTo: baseDirectory) pathString
			asMicResourceReference
]
