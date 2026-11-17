"
I check that `MicNumberer` numbers the chapters and sections of a book: in order, restarting in each chapter and section, from inlined files, with another chapter level, and not the headers of the front matter or of an environment.
"
Class {
	#name : 'MicNumbererTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicNumbererTest >> number: aString [
	"Parse aString, number it with chapters at ## and answer it."

	| document |
	document := Microdown parse: aString.
	MicNumberer new number: document.
	^ document
]

{ #category : 'helpers' }
MicNumbererTest >> numbersOf: aDocument [
	"Answer, for each header directly in aDocument, its text and its number (nil when it has none)."

	^ (aDocument children select: [ :each | each isHeader ])
		  collect: [ :each |
		  each text -> (each propertyAt: #number ifAbsent: [ nil ]) ]
		  as: Array
]

{ #category : 'tests - chapters' }
MicNumbererTest >> testChapterLevelOne [

	| document |
	document := Microdown parse: '# A

## a1

# B

## b1'.

	MicNumberer new
		chapterLevel: 1;
		number: document.

	self assert: (self numbersOf: document) equals: {
			('A' -> #( 1 )).
			('a1' -> #( 1 1 )).
			('B' -> #( 2 )).
			('b1' -> #( 2 1 )) }
]

{ #category : 'tests - chapters' }
MicNumbererTest >> testChaptersAreNumberedInOrder [

	self
		assert: (self numbersOf: (self number: '## A

## B

## C'))
		equals: {
				('A' -> #( 1 )).
				('B' -> #( 2 )).
				('C' -> #( 3 )) }
]

{ #category : 'tests - example' }
MicNumbererTest >> testExampleOfABook [

	self
		assert: (self numbersOf: MicNumberer exampleOfABook document)
		equals: {
				('Foreword' -> nil).
				('First chapter' -> #( 1 )).
				('Text' -> #( 1 1 )).
				('Figures' -> #( 1 2 )).
				('Second chapter' -> #( 2 )).
				('Math' -> #( 2 1 )) }
]

{ #category : 'tests - sections' }
MicNumbererTest >> testHeaderInsideAnEnvironmentIsNotNumbered [

	| document |
	document := self number: '## One

<!card
### Inside
!>

### a1'.

	self deny:
		(document children second children first hasProperty: #number).
	self assert: (self numbersOf: document) equals: {
			('One' -> #( 1 )).
			('a1' -> #( 1 1 )) }
]

{ #category : 'tests - chapters' }
MicNumbererTest >> testHeadersBeforeTheFirstChapterAreNotNumbered [

	self
		assert: (self numbersOf: (self number: '### Foreword

Text.

## A'))
		equals: {
				('Foreword' -> nil).
				('A' -> #( 1 )) }
]

{ #category : 'tests - chapters' }
MicNumbererTest >> testHeadersOfInlinedFilesAreNumbered [

	| book document |
	book := FileSystem memory / 'book'.
	book ensureCreateDirectory.
	book / 'index.md' writeStreamDo: [ :stream |
			stream nextPutAll: '<!inputFile|path=one.md!>

<!inputFile|path=two.md!>' ].
	book / 'one.md' writeStreamDo: [ :stream |
			stream nextPutAll: '## One

### a1' ].
	book / 'two.md' writeStreamDo: [ :stream |
			stream nextPutAll: '## Two

### b1' ].
	document := (book / 'index.md') asMicResourceReference loadMicrodown
		            inlineInputFiles.

	MicNumberer new number: document.

	self
		assert: (document children
				 flatCollect: [ :each | self numbersOf: each ]
				 as: Array)
		equals: {
				('One' -> #( 1 )).
				('a1' -> #( 1 1 )).
				('Two' -> #( 2 )).
				('b1' -> #( 2 1 )) }
]

{ #category : 'tests - chapters' }
MicNumbererTest >> testLessDeepHeaderIsAChapterToo [

	self
		assert: (self numbersOf: (self number: '# Book

## A

### a1'))
		equals: {
				('Book' -> #( 1 )).
				('A' -> #( 2 )).
				('a1' -> #( 2 1 )) }
]

{ #category : 'tests - sections' }
MicNumbererTest >> testSectionsAreNumberedInTheirChapter [

	self
		assert: (self numbersOf: (self number: '## A

### a1

### a2

## B

### b1'))
		equals: {
				('A' -> #( 1 )).
				('a1' -> #( 1 1 )).
				('a2' -> #( 1 2 )).
				('B' -> #( 2 )).
				('b1' -> #( 2 1 )) }
]

{ #category : 'tests - sections' }
MicNumbererTest >> testSkippedLevelIsNumberedZero [

	self
		assert: (self numbersOf: (self number: '## A

#### x'))
		equals: {
				('A' -> #( 1 )).
				('x' -> #( 1 0 1 )) }
]

{ #category : 'tests - sections' }
MicNumbererTest >> testSubsectionsRestartInEachSection [

	self
		assert: (self numbersOf: (self number: '## A

### a1

#### x

#### y

### a2

#### z'))
		equals: {
				('A' -> #( 1 )).
				('a1' -> #( 1 1 )).
				('x' -> #( 1 1 1 )).
				('y' -> #( 1 1 2 )).
				('a2' -> #( 1 2 )).
				('z' -> #( 1 2 1 )) }
]
