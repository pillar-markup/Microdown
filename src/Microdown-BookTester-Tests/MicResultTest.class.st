Class {
	#name : 'MicResultTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicResultTest >> testReportingDuplicatedAnchors [

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
MicResultTest >> testReportingDuplicatedAnchorsInFile [ 

	| fs dir  file  visitor |
	fs := FileSystem memory .
	dir := (fs / 'myDirectory ') asFileReference .
	dir ensureCreateDirectory . 
	file := (dir / 'file.txt') asFileReference . 

 
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1

# Section 2
@anchorSection1

# Section 3
@anchorSection1

See *@anchorSection1@* and *@anchorSection0@*

'] .
	file ensureCreateFile .
	

	visitor := MicReferenceChecker new. 
	visitor checkFile: file .
	self deny: (visitor isOkay).
	self 
		assert: (visitor allTestsResults collect: [:each | each anchorLabel]) 
		equals: OrderedCollection <- #('anchorSection1' 'anchorSection1'). 
]

{ #category : 'tests' }
MicResultTest >> testReportingDuplicatedFigures [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@* and *@anchorSection3@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOkay.
	self
		assert: (visitor allTestsResults collect: [ :each | each anchorLabel ])
		equals: OrderedCollection <- #( 'anchorSection1' )
]

{ #category : 'tests' }
MicResultTest >> testReportingDuplicatedFiguresInFile [ 

	| fs dir  file  visitor |
	fs := FileSystem memory .
	dir := (fs / 'myDirectory ') asFileReference .
	dir ensureCreateDirectory . 
	file := (dir / 'file.txt') asFileReference . 

	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@* and *@anchorSection3@*

'].
	file ensureCreateFile .
	

	visitor := MicReferenceChecker new. 
	visitor checkFile: file .
	self deny: (visitor isOkay).
	self 
		assert: (visitor allTestsResults collect: [:each | each anchorLabel]) 
		equals: OrderedCollection <- #('anchorSection1' 'anchorSection1' 'anchorSection1'). 
]

{ #category : 'tests' }
MicResultTest >> testReportingDuplicatedMaths [

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
MicResultTest >> testReportingDuplicatedMathsInFile [ 

	| fs dir  file  visitor |
	fs := FileSystem memory .
	dir := (fs / 'myDirectory ') asFileReference  .
	dir ensureCreateDirectory . 
	file := (dir / 'file.txt') asFileReference . 

	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 
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

See *@anchorSection1@* and *@anchorSection3@*

'] .
	file ensureCreateFile .

	visitor := MicReferenceChecker new. 
	visitor checkFile: file .
	self deny: (visitor isOkay).
	self assert: visitor allTestsResults first source equals: file fullName .
	self 
		assert: (visitor allTestsResults collect: [:each | each anchorLabel]) 
		equals: OrderedCollection <- #('anchorSection2' 'anchorSection1' ). 
]
