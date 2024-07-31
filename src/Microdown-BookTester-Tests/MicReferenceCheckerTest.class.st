Class {
	#name : 'MicReferenceCheckerTest',
	#superclass : 'MicFileTest',
	#instVars : [
		'fileDefAncS1UndAncS0',
		'refAncS1',
		'defEq1AndReferToEq1'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'helpers - anchors & references' }
MicReferenceCheckerTest >> defEq1AndReferToEq1 [

	defEq1AndReferToEq1 := self fileSystem / 'defEq1AndReferToEq1.md'.
	defEq1AndReferToEq1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
	
$$ %anchor=Eq1
balbalbalb! 
$$
See *@Eq1@*

' ].
	defEq1AndReferToEq1 ensureCreateFile
]

{ #category : 'helpers - anchors & references' }
MicReferenceCheckerTest >> fileDefAncS1UndAncS0 [

	fileDefAncS1UndAncS0 := self fileSystem / 'fileDefAncS1UndAncS0.md'.
	fileDefAncS1UndAncS0 ensureCreateFile.
	fileDefAncS1UndAncS0 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
		
![alittle caption.](figures/f.png anchor=ancS1)

See *@ancS0@*

' ]
]

{ #category : 'helpers - anchors & references' }
MicReferenceCheckerTest >> fileRefAncS1 [

	refAncS1 := self fileSystem / 'fileRefAncS1.md'.
	refAncS1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1

See *@ancS1@*
' ].
	refAncS1 ensureCreateFile
]

{ #category : 'running' }
MicReferenceCheckerTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'running' }
MicReferenceCheckerTest >> setUp [

	super setUp.
	fs := self fileSystem.
	dir := (fs / 'myDirectory') asFileReference.
	dir ensureCreateDirectory
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testAllReferencesAreCorrect [

	| doc visitor |
	doc := Microdown parse:	'# Section 1
@anchorSection1

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new. 
	doc accept: visitor. 
	self assert: visitor isOkay 
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testAllReferencesAreCorrectinDir [

	| aSectionWithAnchorAndRef file2 visitor|
	
	aSectionWithAnchorAndRef := (dir / 'aSectionWithAnchorAndRef.txt') asFileReference.
	aSectionWithAnchorAndRef writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
@anchorSection1

See *@anchorSection1@*

' ].
	aSectionWithAnchorAndRef ensureCreateFile.
	
	file2 := (dir / 'justReferenceToSection.txt') asFileReference.
	file2 writeStreamDo: [ :stream2 |
		stream2 nextPutAll: ' Just a reference See *@anchorSection1@*  ' ].
	file2 ensureCreateFile.
	
	visitor := MicReferenceChecker new.
	self assert: (visitor checkDirectory: dir)
]

{ #category : 'skipped for now' }
MicReferenceCheckerTest >> testDuplicatedAnchorDir [

	| dir file1 file2 visitor   |
	self skip.
	dir := (FileSystem workingDirectory / 'myDirectory') asFileReference.
   dir ensureCreateDirectory.
	
	file1 := (FileSystem workingDirectory / 'myDirectory' / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1


' ] .
	file1 ensureCreateFile .
	
	file2 := (FileSystem workingDirectory / 'myDirectory' / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection3

# Section 4
@anchorSection1


'] .
   file2 ensureCreateFile . 

	visitor := MicReferenceChecker new.

	self deny: ( visitor checkDirectory: dir ) 
	
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testDuplicatedAnchorInDifferentFilesOfTheSameDir [

	| file1 file2 visitor |
	file1 := (dir / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1


' ].
	file1 ensureCreateFile.
	file2 := (dir / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection3

# Section 4
@anchorSection1


' ].
	file2 ensureCreateFile.
	
	visitor := MicReferenceChecker new.
	self deny: (visitor checkDirectory: dir)
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testFileWithReferenceToUnexistingAnchor [

	| referenceToUnexistingAnchor visitor |
	referenceToUnexistingAnchor := (fs/ 'referenceToUnexistingAnchor.txt') asFileReference.
	referenceToUnexistingAnchor ensureCreateFile.
	referenceToUnexistingAnchor writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
		
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection0@*

' ].
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: referenceToUnexistingAnchor)
]

{ #category : 'tests - full project' }
MicReferenceCheckerTest >> testFullProject [

	| checker |
	self createTestProjectBadAndCorrectReferences.
	checker := MicReferenceChecker new.
	self deny: (checker checkProject: section1 fileSystem: fs).
	self flag: #shouldImproveTestAssertions.
	self flag: #shouldDefineAWorkingProjectToo.
	self assert: checker results size equals: 4
]

{ #category : 'tests - single file' }
MicReferenceCheckerTest >> testNoDefButRefersToUnknownAnchor [

	| visitor |
	self fileRefAncS1.
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: refAncS1).
	self assert: visitor results size equals: 1.
	self assert: visitor results first anchorLabel equals: 'ancS1'.
	self
		assert: visitor results first source
		equals: '/fileRefAncS1.md'
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testReferToAFigure [

	| doc visitor |
	doc := Microdown parse: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self assert: visitor isOkay
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testReferToAFigureInFile [

	| referenceToFigure visitor |
	referenceToFigure := (dir / 'referenceToFigure.txt') asFileReference.
	referenceToFigure writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
		
![alittle caption.](figures/f.png anchor=anchorFigure1)

See *@anchorFigure1@*

' ].
	referenceToFigure ensureCreateFile.
	visitor := MicReferenceChecker new.
	self assert: (visitor checkFile: referenceToFigure)
	
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testReferToAMathEquation [

	| doc visitor |
	doc := Microdown parse: '# Section 1
	
$$ %anchor=anchorSection1
balbalbalb! 
$$
See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self assert: visitor isOkay
]

{ #category : 'tests - single file' }
MicReferenceCheckerTest >> testReferToAMathEquationInFile [

	| visitor |
	self defEq1AndReferToEq1.
	visitor := MicReferenceChecker new.
	self assert: (visitor checkFile: defEq1AndReferToEq1).
	self assert: visitor results size equals: 0.
	
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testReferToAnUknownAnchor [

	| doc visitor |
	doc := Microdown parse: '# Section 1

See *@anchorSection1@*

'.
	doc fromFile: 'fakedFile'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testReferToAnUknownAnchorInFile [ 

	| file  visitor |
	file := (FileSystem memory / 'myFile.txt') asFileReference.
   file ensureCreateFile.
	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1

See *@anchorSection1@*

' ] .
	
	
	visitor := MicReferenceChecker new. 
	self deny: (visitor checkFile: file).
	file ensureDelete 
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testReferenceToFigureAnchor [

	| referenceToFigureAnchor visitor |
	referenceToFigureAnchor := (fs / 'referenceToFigureAnchor.md')  asFileReference.
	referenceToFigureAnchor ensureCreateFile.
	referenceToFigureAnchor writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection0@*

' ].
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: referenceToFigureAnchor)
]

{ #category : 'tests - references in a single file' }
MicReferenceCheckerTest >> testReferenceToNonExistingAnchor [

	| referenceToFigureAnchor visitor |
	referenceToFigureAnchor := (fs / 'referenceToFigureAnchor.md') asFileReference.
	referenceToFigureAnchor ensureCreateFile.
	referenceToFigureAnchor writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection0@*

' ].
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: referenceToFigureAnchor)
]

{ #category : 'tests - single file' }
MicReferenceCheckerTest >> testRefersToUnknownAnchor [

	| visitor |
	self fileDefAncS1UndAncS0.
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: fileDefAncS1UndAncS0).
	self assert: visitor results size equals: 1.
	self assert: visitor results first anchorLabel equals: 'ancS0'.
	self assert: visitor results first source equals: '/fileDefAncS1UndAncS0.md'.
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedAnchorBetweenSectionAndFigure [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)


# Section 1
@anchorSection1

We have a conflict between the section and the figure.

# Section 2
@anchorSection2

# Section 3
@anchorSection3

$$ %anchor=anchorSection0
balbalbalb! 
$$

See *@anchorSection1@* and *@anchorSection0@*

' ].
	file ensureCreateFile.
	
	
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file).
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection0')
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedAnchors [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

# Section 1
@anchorSection1

# Section 2
@anchorSection1


See *@anchorSection1@* and *@anchorSection0@*

'.
	doc fromFile: 'fakedFile'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedAnchorsInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1

# Section 2
@anchorSection1

# Section 3
@anchorSection1

See *@anchorSection1@* and *@anchorSection0@*

' ].
	file ensureCreateFile.
	
	
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file).
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedFigures [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@*

'.
	doc fromFile: 'fakedFile'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedFiguresInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@* 

' ].
	file ensureCreateFile.
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file).
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection
			<- #( 'anchorSection1' 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedMaths [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection3
balbalbalb! 
$$

$$ %anchor=anchorSection3
balbalbalb! 
$$

See *@anchorSection1@* and *@anchorSection3@*

'.
	doc fromFile: 'fakedFile'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection3' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedMathsInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection2
balbalbalb! 
$$

$$ %anchor=anchorSection2
balbalbalb! 
$$

$$ %anchor=anchorSection1
balbalbalb! 
$$

See *@anchorSection1@* 

' ].
	file ensureCreateFile.
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file).
	self
		assert: visitor results first source
		equals: file fullName.
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection2' 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingDuplicatedSectionAnchorsInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1

# Section 2
@anchorSection1

# Section 3
@anchorSection1

See *@anchorSection1@* and *@anchorSection0@*

' ].
	file ensureCreateFile.
	
	
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file).
	self
		assert:
		(visitor results collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests - reporting' }
MicReferenceCheckerTest >> testReportingUnknownAnchor [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

# Section 1
@anchorSection1

See *@anchorSection1@* and *@anchorSection2@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOk.
	self 
		assert: (visitor unknownAnchors collect: [ :each | each anchorLabel ]) 
		equals: (OrderedCollection <- #('anchorSection2'))  
]

{ #category : 'skipped for now' }
MicReferenceCheckerTest >> testReportingUnknownAnchorDir [

	| dir file1 file2 visitor |
	self skip.
	dir := (FileSystem workingDirectory / 'myDirectory') asFileReference.
   dir ensureCreateDirectory.
	
	file1 := (FileSystem workingDirectory / 'myDirectory' / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1


' ].
	file1 ensureCreateFile.
	
	file2 := (FileSystem workingDirectory / 'myDirectory' / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream | stream nextPutAll: ' See *@anchorSection1@* and *@anchorSection2@*'].
   file2 ensureCreateFile. 

	visitor := MicReferenceChecker new.

	self deny: (visitor checkDirectory: dir).
	
	file1 ensureDelete.
   file2 ensureDelete.
   dir ensureDelete 
	
]
