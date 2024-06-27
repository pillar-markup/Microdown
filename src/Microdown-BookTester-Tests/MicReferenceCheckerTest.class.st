Class {
	#name : 'MicReferenceCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fs',
		'dir'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'utils' }
MicReferenceCheckerTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicReferenceCheckerTest >> testAllReferencesAreCorrectInFile [

	|  file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1

See *@anchorSection1@*

' ].
	file ensureCreateFile.
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file)
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testAllReferencesAreCorrectinDir [

	| file1 file2 visitor |

	file1 := (dir / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
@anchorSection1

See *@anchorSection1@*

' ].
	file1 ensureCreateFile.
	file2 := (dir / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream2 |
		stream2 nextPutAll: ' Just a reference See *@anchorSection1@*  ' ].
	file2 ensureCreateFile.
	visitor := MicReferenceChecker new.
	self assert: (visitor checkDirectory: dir)
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testDuplicatedAnchorDir [

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

{ #category : 'tests' }
MicReferenceCheckerTest >> testFile [

	| file visitor |
	file := (fs/ 'myFile.txt') asFileReference.
	file ensureCreateFile.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection0@*

' ].
	visitor := MicReferenceChecker new.
	self deny: (visitor checkFile: file)
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

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAFigureInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection1@*

' ].
	file ensureCreateFile.
	visitor := MicReferenceChecker new.
	self assert: (visitor checkFile: file)
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

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAMathEquationInFile [

	| file visitor |
	file := (dir / 'file.txt') asFileReference.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 1
	
$$ %anchor=anchorSection1
balbalbalb! 
$$
See *@anchorSection1@*

' ].
	file ensureCreateFile.
	visitor := MicReferenceChecker new.
	self assert: (visitor checkFile: file)
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testReferToAnUknownAnchor [

	| doc visitor |
	doc := Microdown parse: '# Section 1

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay 
]

{ #category : 'tests - parse only' }
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
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self assert: (visitor allTestsResults collect: [:each | each anchorLabel ]) equals: OrderedCollection <- #('anchorSection1')
]

{ #category : 'tests' }
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
		(visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests - parse only' }
MicReferenceCheckerTest >> testReportingDuplicatedFigures [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self
		assert: (visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' )
]

{ #category : 'tests' }
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
		(visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection
			<- #( 'anchorSection1' 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests - parse only' }
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
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay .
	self
		assert: (visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection3' )
]

{ #category : 'tests' }
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
		assert: visitor allTestsResults first source
		equals: file fullName.
	self
		assert:
		(visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection2' 'anchorSection1' )
]
