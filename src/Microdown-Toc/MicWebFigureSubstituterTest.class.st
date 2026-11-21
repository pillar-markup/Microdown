"
I test `MicWebFigureSubstituter`, the pass that replaces a PDF figure by the PNG file next to it so that a browser can show it. Each test writes a small book in a memory file system (`writeFile:contents:`), loads its `index.md` as Pillar does and runs the substituter on it (`substitutedIndex`).
"
Class {
	#name : 'MicWebFigureSubstituterTest',
	#superclass : 'TestCase',
	#instVars : [
		'book'
	],
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicWebFigureSubstituterTest >> figureOfIndex [
	"The figure of a book whose index.md holds one figure."

	^ self substitutedIndex children first children first
]

{ #category : 'running' }
MicWebFigureSubstituterTest >> setUp [

	super setUp.
	book := FileSystem memory / 'book'.
	book ensureCreateDirectory
]

{ #category : 'helpers' }
MicWebFigureSubstituterTest >> substitutedIndex [
	"Load index.md of the book with its input files inlined, as Pillar does, and substitute its PDF figures."

	| document |
	document := (book / 'index.md') asMicResourceReference loadMicrodown
		            inlineInputFiles.
	MicWebFigureSubstituter new substitute: document.
	^ document
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testExampleOfABook [

	self
		assert:
			MicWebFigureSubstituter exampleOfABook document children first
				children first children first reference fileReference basename
		equals: 'x.png'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testFigureArgumentsAreKept [

	self
		writeFile: 'index.md'
		contents: '![A caption.%width=40&anchor=f](figures/x.pdf)';
		writeFile: 'figures/x.png' contents: ''.

	self assert: (self figureOfIndex arguments at: #width) equals: '40'.
	self assert: self figureOfIndex anchor equals: 'f'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testFigureOfADocumentNotLoadedFromAFileIsLeftAlone [

	| document |
	document := Microdown parse: '![A caption.](figures/x.pdf)'.

	MicWebFigureSubstituter new substitute: document.

	self
		assert: document children first children first reference path
		equals: 'figures/x.pdf'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testPdfFigureWithAPngIsReplacedByThePng [

	self
		writeFile: 'index.md' contents: '![A caption.](figures/x.pdf)';
		writeFile: 'figures/x.pdf' contents: '';
		writeFile: 'figures/x.png' contents: ''.

	self
		assert: self figureOfIndex reference fileReference
		equals: book / 'figures' / 'x.png'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testPdfFigureWithoutAPngIsLeftAlone [

	self
		writeFile: 'index.md' contents: '![A caption.](figures/x.pdf)';
		writeFile: 'figures/x.pdf' contents: ''.

	self
		assert: self figureOfIndex reference fileReference
		equals: book / 'figures' / 'x.pdf'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testPngFigureIsLeftAlone [

	self
		writeFile: 'index.md' contents: '![A caption.](figures/x.png)';
		writeFile: 'figures/x.png' contents: ''.

	self
		assert: self figureOfIndex reference fileReference
		equals: book / 'figures' / 'x.png'
]

{ #category : 'tests' }
MicWebFigureSubstituterTest >> testWebFigureIsLeftAlone [

	self
		writeFile: 'index.md'
		contents: '![A caption.](https://pharo.org/x.pdf)'.

	self
		assert: self figureOfIndex reference uri printString
		equals: 'https://pharo.org/x.pdf'
]

{ #category : 'helpers' }
MicWebFigureSubstituterTest >> writeFile: aPath contents: aString [

	| file |
	file := book resolve: aPath.
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ]
]
