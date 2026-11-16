"
I check that `MicChapterSplitter` cuts a book at its chapter headers, keeps each element in its chapter, puts what comes before the first chapter in the front matter, and goes through the files inlined in the book.
"
Class {
	#name : 'MicChapterSplitterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicChapterSplitterTest >> split: aString [
	"Answer a splitter that split the Microdown text aString at its default chapter level."

	^ MicChapterSplitter new
		  split: (Microdown parse: aString);
		  yourself
]

{ #category : 'tests - front matter' }
MicChapterSplitterTest >> testBookStartingWithAChapterHasAnEmptyFrontMatter [

	self assert: (self split: '## One') frontMatter children isEmpty
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testChapterIsADocumentOfItsOwn [

	| chapter |
	chapter := (self split: '## One

Some text.') chapters first.

	self assert: chapter class equals: MicRootBlock.
	self assert: chapter children first parent identicalTo: chapter
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testChapterKeepsItsElementsUntilTheNextChapter [

	| chapter |
	chapter := (self split: '## One

Some text.

```
code
```

## Two') chapters first.

	self
		assert: (chapter children collect: [ :each | each class ] as: Array)
		equals: {
				MicHeaderBlock.
				MicParagraphBlock.
				MicCodeBlock }
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testChapterLevelOne [

	| splitter |
	splitter := MicChapterSplitter new
		            chapterLevel: 1;
		            split: (Microdown parse: '# Part

## One

# Other part');
		            yourself.

	self
		assert: (self titlesOf: splitter)
		equals: #( 'Part' 'Other part' )
]

{ #category : 'tests - inlined files' }
MicChapterSplitterTest >> testChaptersComeFromTheInlinedFiles [

	| book document splitter |
	book := FileSystem memory / 'book'.
	book ensureCreateDirectory.
	book / 'index.md' writeStreamDo: [ :stream |
			stream nextPutAll: 'Welcome.

<!inputFile|path=one.md!>

<!inputFile|path=two.md!>' ].
	book / 'one.md' writeStreamDo: [ :stream |
			stream nextPutAll: '## One

### A

## Two' ].
	book / 'two.md' writeStreamDo: [ :stream |
		stream nextPutAll: '## Three' ].
	document := (book / 'index.md') asMicResourceReference loadMicrodown
		            inlineInputFiles.

	splitter := MicChapterSplitter new
		            split: document;
		            yourself.

	self
		assert: (self titlesOf: splitter)
		equals: #( 'One' 'Two' 'Three' ).
	self
		assert: (splitter chapters first children
				 collect: [ :each | each text ]
				 as: Array)
		equals: #( 'One' 'A' ).
	self assert: splitter frontMatter children size equals: 1
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testDeeperHeadersStayInTheirChapter [

	| splitter |
	splitter := self split: '## One

### A

#### B

## Two'.

	self assert: (self titlesOf: splitter) equals: #( 'One' 'Two' ).
	self assert: splitter chapters first children size equals: 3
]

{ #category : 'tests - front matter' }
MicChapterSplitterTest >> testElementsBeforeTheFirstChapterAreTheFrontMatter [

	| splitter |
	splitter := self split: 'An introduction.

## One'.

	self
		assert: (splitter frontMatter children
				 collect: [ :each | each class ]
				 as: Array)
		equals: { MicParagraphBlock }.
	self assert: (self titlesOf: splitter) equals: #( 'One' )
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testHeaderInsideAnEnvironmentDoesNotStartAChapter [

	| splitter |
	splitter := self split: '## One

<!card
## Inside
!>'.

	self assert: (self titlesOf: splitter) equals: #( 'One' ).
	self
		assert: (splitter chapters first children
				 collect: [ :each | each class ]
				 as: Array)
		equals: {
				MicHeaderBlock.
				MicEnvironmentBlock }
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testLessDeepHeaderAlsoStartsAChapter [

	self
		assert: (self titlesOf: (self split: '# Part

## One'))
		equals: #( 'Part' 'One' )
]

{ #category : 'tests - chapters' }
MicChapterSplitterTest >> testSplitAtChapterHeaders [

	self
		assert: (self titlesOf: (self split: '## One

Some text.

## Two

More text.'))
		equals: #( 'One' 'Two' )
]

{ #category : 'tests - front matter' }
MicChapterSplitterTest >> testTextWithoutChapterIsAllFrontMatter [

	| splitter |
	splitter := self split: 'Some text.

### Not a chapter'.

	self assert: splitter chapters isEmpty.
	self assert: splitter frontMatter children size equals: 2
]

{ #category : 'helpers' }
MicChapterSplitterTest >> titlesOf: aSplitter [
	"Answer the text of the header that starts each chapter of aSplitter."

	^ aSplitter chapters
		  collect: [ :each | each children first text ]
		  as: Array
]
