"
I check that `MicPathRelativizer` makes the figures of a book loaded from a memory file system relative to the book folder (in the index and in inlined files), and leaves alone the figures that are relative already, on the web, or outside the book.
"
Class {
	#name : 'MicPathRelativizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'book'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicPathRelativizerTest >> figureOfChapter [
	"The figure of a book whose index.md inlines a chapter holding one figure."

	self
		writeFile: 'index.md'
		contents: '<!inputFile|path=Chapters/one.md!>'.
	^ self relativizedIndex children first children first children first
]

{ #category : 'helpers' }
MicPathRelativizerTest >> figureOfIndex [
	"The figure of a book whose index.md holds one figure."

	^ self relativizedIndex children first children first
]

{ #category : 'helpers' }
MicPathRelativizerTest >> relativizedIndex [
	"Load index.md of the book with its input files inlined, as Pillar does, and relativize its paths to the book folder."

	| document |
	document := (book / 'index.md') asMicResourceReference loadMicrodown
		            inlineInputFiles.
	MicPathRelativizer new relativize: document to: book.
	^ document
]

{ #category : 'running' }
MicPathRelativizerTest >> setUp [

	super setUp.
	book := FileSystem memory / 'book'.
	book ensureCreateDirectory
]

{ #category : 'tests - figures left alone' }
MicPathRelativizerTest >> testFigureOfADocumentNotLoadedFromAFileIsLeftAlone [

	| document |
	document := Microdown parse: '![A caption.](figures/x.png)'.

	MicPathRelativizer new relativize: document to: book.

	self
		assert: document children first children first reference path
		equals: 'figures/x.png'
]

{ #category : 'tests - local figures' }
MicPathRelativizerTest >> testFigureOfAnInputFileIsRelativeToTheBook [

	self
		writeFile: 'Chapters/one.md'
		contents: '![A caption.](figures/x.png)'.

	self
		assert: self figureOfChapter reference path
		equals: 'Chapters/figures/x.png'
]

{ #category : 'tests - local figures' }
MicPathRelativizerTest >> testFigureOfTheIndexIsRelativeToTheBook [

	self writeFile: 'index.md' contents: '![A caption.](figures/top.png)'.

	self
		assert: self figureOfIndex reference path
		equals: 'figures/top.png'
]

{ #category : 'tests - figures left alone' }
MicPathRelativizerTest >> testFigureOutsideTheBookIsLeftAlone [

	self writeFile: 'index.md' contents: '![A caption.](../shared/y.png)'.

	self
		assert: self figureOfIndex reference path
		equals: '/shared/y.png'
]

{ #category : 'tests - local figures' }
MicPathRelativizerTest >> testRelativizedFigureHasARelativeReference [

	self
		writeFile: 'Chapters/one.md'
		contents: '![A caption.](figures/x.png)'.

	self assert: self figureOfChapter reference isRelative
]

{ #category : 'tests - local figures' }
MicPathRelativizerTest >> testRelativizedFigureIsWrittenWithItsPathInTheBook [

	self
		writeFile: 'index.md'
		contents: '<!inputFile|path=Chapters/one.md!>';
		writeFile: 'Chapters/one.md'
		contents: '![A caption.](figures/x.png)'.

	self assert: ((MicHTMLVisitor new
			  visit: self relativizedIndex;
			  contents) includesSubstring: 'src="Chapters/figures/x.png"')
]

{ #category : 'tests - figures left alone' }
MicPathRelativizerTest >> testWebFigureIsLeftAlone [

	self
		writeFile: 'index.md'
		contents: '![A caption.](https://pharo.org/x.png)'.

	self
		assert: self figureOfIndex reference uri printString
		equals: 'https://pharo.org/x.png'
]

{ #category : 'helpers' }
MicPathRelativizerTest >> writeFile: aPath contents: aString [

	| file |
	file := book resolve: aPath.
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ]
]
