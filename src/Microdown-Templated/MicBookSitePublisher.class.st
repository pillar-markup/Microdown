"
I publish a book written in Microdown as a web site: one HTML page per chapter, written with the Mustache templates of the book, plus the support files (CSS, fonts, scripts) the pages refer to.

A book folder follows the Pillar layout: `index.md` lists the chapters with inputFile blocks (`<!inputFile|path=Chapters/Chapter1/chapter1.md!>`), `_support/templates/html` holds the templates and `_support/html` the support files.

## Life cycle: who creates me and who uses me

1. A user (and later the `pillar publish` command) creates me with `bookDirectory:`, and optionally `outputDirectory:`.
2. `publish` copies the support files, then reads `index.md` and writes each chapter as a page named after its file (`chapter1.md` gives `chapter1.html`).
3. Publishing again replaces the pages and the support files.

## Responsibility:

- I find the chapters of a book from its index.
- I write each chapter with a `MicTHTMLDocumentMaker` that uses the templates of the book.
- I give the root template of each page its `title` and its `toc` (table of contents), built by `MicTocBuilder` (`templateValues`) once `MicHeaderIdentifier` gave the headers the targets its links point to.
- I lay out the site in my output directory (`_result/site` in the book by default).

## Collaborators: 

- `MicTHTMLDocumentMaker`: turns a chapter document into templated HTML (through `MicTemplatedWriter`).
- `MicInputfileBlock`: the blocks of the index that name the chapter files.
- `MicHeaderIdentifier`: gives the headers of a chapter their link targets.
- `MicTocBuilder`: builds the table of contents of a chapter (headers up to level 3) as template values.
- `MicResourceReference` (`loadMicrodown`): parses the index and the chapters, resolving their relative paths.

## Public API and Key Messages

- `bookDirectory: aFileReference` the folder of the book.
- `outputDirectory: aFileReference` where to write the site.
- `publish` writes the site.
- `chapterFiles` the chapter files, in the order of the index.
- `tableOfContentsOf: aDocument` the table of contents of a chapter, as the templates get it (see `MicTocBuilder>>templateValues`), e.g. `{{#toc}}{{#children}}<a href=""{{href}}"">{{name}}</a>{{/children}}{{/toc}}`.

## Examples

```
MicBookSitePublisher exampleInMemoryBook publish
```

## Internal Representation

- `bookDirectory`: the folder of the book.
- `outputDirectory`: the folder of the site, `nil` for the default one.

### Implementation Points

- Write `{{#toc}}{{#children}}...{{/children}}{{/toc}}` rather than `{{#toc.children}}` inside `{{#toc}}`: Mustache does not find the enclosing context inside a section.
- Only the inputFile blocks at the top level of `index.md` are chapters.
- Figures are not copied to the site yet: a page refers to `figures/x.png` while the file stays in the chapter folder of the book.
"
Class {
	#name : 'MicBookSitePublisher',
	#superclass : 'Object',
	#instVars : [
		'bookDirectory',
		'outputDirectory'
	],
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'examples' }
MicBookSitePublisher class >> exampleInMemoryBook [
	"A publisher for a small book of two chapters, in a memory file system."

	<sampleInstance>
	| book |
	book := FileSystem memory / 'book'.
	(book / 'Chapters') ensureCreateDirectory.
	book / 'index.md' writeStreamDo: [ :stream |
			stream nextPutAll: '<!inputFile|path=Chapters/one.md!>

<!inputFile|path=Chapters/two.md!>' ].
	book / 'Chapters' / 'one.md' writeStreamDo: [ :stream |
		stream nextPutAll: '# First chapter' ].
	book / 'Chapters' / 'two.md' writeStreamDo: [ :stream |
		stream nextPutAll: '# Second chapter' ].
	^ self new
		  bookDirectory: book;
		  yourself
]

{ #category : 'accessing' }
MicBookSitePublisher >> bookDirectory [

	^ bookDirectory
]

{ #category : 'accessing' }
MicBookSitePublisher >> bookDirectory: aFileReference [

	bookDirectory := aFileReference
]

{ #category : 'publishing' }
MicBookSitePublisher >> chapterFiles [
	"Answer the chapter files that the index includes with inputFile blocks, in their order."

	| index |
	index := self indexFile asMicResourceReference loadMicrodown.
	^ index children
		  select: [ :each | each class = MicInputfileBlock ]
		  thenCollect: [ :each | each path fileReference ]
]

{ #category : 'publishing' }
MicBookSitePublisher >> copySupportFiles [
	"Replace the support files of the site by the ones of the book."

	| target |
	target := self outputDirectory / '_support' / 'html'.
	target ensureDeleteAll.
	target parent ensureCreateDirectory.
	self supportDirectory exists ifTrue: [
		self supportDirectory copyAllTo: target ]
]

{ #category : 'publishing' }
MicBookSitePublisher >> documentMaker [

	^ MicTHTMLDocumentMaker new
		  templateDirectory: self templateDirectory;
		  yourself
]

{ #category : 'accessing' }
MicBookSitePublisher >> indexFile [
	"The file listing the chapters of the book with inputFile blocks."

	^ bookDirectory / 'index.md'
]

{ #category : 'accessing' }
MicBookSitePublisher >> outputDirectory [

	^ outputDirectory ifNil: [ bookDirectory / '_result' / 'site' ]
]

{ #category : 'accessing' }
MicBookSitePublisher >> outputDirectory: aFileReference [

	outputDirectory := aFileReference
]

{ #category : 'publishing' }
MicBookSitePublisher >> pageArgumentsOf: aDocument named: aString [
	"Answer the values the root template gets for the page of aDocument: its title (its first header, else aString) and its table of contents, absent when it has no header."

	| arguments toc |
	arguments := Dictionary new.
	toc := self tableOfContentsOf: aDocument.
	(toc at: 'children') ifNotEmpty: [ :entries |
			arguments at: 'toc' put: toc.
			arguments at: 'title' put: (entries first at: 'name') ].
	arguments at: 'title' ifAbsentPut: [ aString ].
	^ arguments
]

{ #category : 'publishing' }
MicBookSitePublisher >> publish [
	"Write the book as a web site in my output directory: one page per chapter, and the support files."

	self outputDirectory ensureCreateDirectory.
	self copySupportFiles.
	self chapterFiles do: [ :each | self publishChapter: each ]
]

{ #category : 'publishing' }
MicBookSitePublisher >> publishChapter: aFileReference [
	"Write the chapter in aFileReference as a page of the site, named after the chapter file. The root template gets the title and the table of contents of the chapter."

	| document maker html page |
	document := aFileReference asMicResourceReference loadMicrodown.
	maker := self documentMaker.
	maker pageArguments: (self
			 pageArgumentsOf: document
			 named: aFileReference basenameWithoutExtension).
	html := maker write: document.
	page := self outputDirectory
	        / (aFileReference basenameWithoutExtension , '.html').
	page ensureDelete.
	page writeStreamDo: [ :stream | stream nextPutAll: html ]
]

{ #category : 'accessing' }
MicBookSitePublisher >> supportDirectory [
	"The files of the book the pages refer to (CSS, fonts, scripts)."

	^ bookDirectory / '_support' / 'html'
]

{ #category : 'table of contents' }
MicBookSitePublisher >> tableOfContentsOf: aDocument [
	"Answer the table of contents of aDocument for the templates (see MicTocBuilder>>#templateValues): its headers up to level 3, identified first so that its links reach them."

	| builder |
	MicHeaderIdentifier new identify: aDocument.
	builder := MicTocBuilder new.
	builder limitUpTo: 3.
	builder visit: aDocument.
	^ builder templateValues
]

{ #category : 'accessing' }
MicBookSitePublisher >> templateDirectory [
	"The Mustache templates of the book, used to write each page."

	^ bookDirectory / '_support' / 'templates' / 'html'
]
