"
I check that `MicNumberer` numbers the chapters and sections of a book (in order, restarting in each chapter and section, from inlined files, with another chapter level, not the headers of the front matter or of an environment) and its figures, listings and equations (per chapter, each kind with its own counter, only with a caption or an anchor).
"
Class {
	#name : 'MicNumbererTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicNumbererTest >> figureAt: anIndex of: aDocument [
	"The figure of the paragraph at anIndex in aDocument."

	^ (aDocument children at: anIndex) children first
]

{ #category : 'helpers' }
MicNumbererTest >> number: aString [
	"Parse aString, number it with chapters at ## and answer it."

	| document |
	document := Microdown parse: aString.
	MicNumberer new number: document.
	^ document
]

{ #category : 'helpers' }
MicNumbererTest >> numberOf: anElement [

	^ anElement propertyAt: #number ifAbsent: [ nil ]
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

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testCodeBlockWithACaptionOrAnAnchorIsNumberedAsAListing [

	| document |
	document := self number: '## A

```caption=Hello
foo
```

```anchor=c2
bar
```'.

	self
		assert: (self numberOf: document children second)
		equals: #( 1 1 ).
	self
		assert: (self numberOf: document children third)
		equals: #( 1 2 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testCodeBlockWithoutCaptionOrAnchorIsNotNumbered [

	| document |
	document := self number: '## A

```
foo
```'.

	self assert: (self numberOf: document children second) isNil
]

{ #category : 'tests - example' }
MicNumbererTest >> testExampleOfABook [

	self
		assert: (self numbersOf: MicNumberer exampleOfABook document)
		equals: {
				('Foreword' -> nil).
				('First chapter' -> #( 1 )).
				('Text' -> #( 1 1 )).
				('Code' -> #( 1 2 )).
				('Second chapter' -> #( 2 )).
				('Math' -> #( 2 1 )) }
]

{ #category : 'tests - example' }
MicNumbererTest >> testExampleOfABookNumbersItsFigureListingAndEquation [

	| document |
	document := MicNumberer exampleOfABook document.

	self
		assert: (self numberOf: (self figureAt: 4 of: document))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (document children at: 6))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (document children at: 9))
		equals: #( 2 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFigureInsideAnEnvironmentIsNumbered [

	| document |
	document := self number: '## A

<!card
![a](a.png)
!>'.

	self
		assert:
		(self numberOf:
			 document children second children first children first)
		equals: #( 1 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFigureWithAnAnchorAndNoCaptionIsNumbered [

	| document |
	document := self number: '## A

![](a.png anchor=fa)'.

	self
		assert: (self numberOf: (self figureAt: 2 of: document))
		equals: #( 1 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFigureWithoutCaptionOrAnchorIsNotNumbered [

	| document |
	document := self number: '## A

![](a.png)

![b](b.png)'.

	self assert: (self numberOf: (self figureAt: 2 of: document)) isNil.
	self
		assert: (self numberOf: (self figureAt: 3 of: document))
		equals: #( 1 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFiguresAreNumberedInTheirChapter [

	| document |
	document := self number: '## A

![a](a.png)

![b](b.png)

## B

![c](c.png)'.

	self
		assert: (self numberOf: (self figureAt: 2 of: document))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (self figureAt: 3 of: document))
		equals: #( 1 2 ).
	self
		assert: (self numberOf: (self figureAt: 5 of: document))
		equals: #( 2 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFiguresBeforeTheFirstChapterAreNotNumbered [

	| document |
	document := self number: '![a](a.png)

## A

![b](b.png)'.

	self assert: (self numberOf: (self figureAt: 1 of: document)) isNil.
	self
		assert: (self numberOf: (self figureAt: 3 of: document))
		equals: #( 1 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testFiguresListingsAndMathHaveTheirOwnCounters [

	| document |
	document := self number: '## A

![a](a.png)

```caption=Hello
foo
```

$$ % anchor=eq1
x
$$

![b](b.png)'.

	self
		assert: (self numberOf: (self figureAt: 2 of: document))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (document children at: 3))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (document children at: 4))
		equals: #( 1 1 ).
	self
		assert: (self numberOf: (self figureAt: 5 of: document))
		equals: #( 1 2 )
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

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testMathBlockWithAnAnchorIsNumbered [

	| document |
	document := self number: '## A

$$ % anchor=eq1
x
$$'.

	self
		assert: (self numberOf: document children second)
		equals: #( 1 1 )
]

{ #category : 'tests - figures, code and math' }
MicNumbererTest >> testMathBlockWithoutAnchorIsNotNumbered [

	| document |
	document := self number: '## A

$$
x
$$'.

	self assert: (self numberOf: document children second) isNil
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
