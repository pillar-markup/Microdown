Class {
	#name : 'MicReferenceCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-ReferenceChecker',
	#package : 'Microdown-ReferenceChecker'
}

{ #category : 'tests' }
MicReferenceCheckerTest >> testAllReferencesAreCorrect [

	| doc visitor |
	doc := Microdown parse:	'# Section 1
@anchorSection1

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new. 
	doc accept: visitor. 
	self assert: visitor isOk.
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testAllReferencesAreCorrectInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1
@anchorSection1

See *@anchorSection1@*

' ] .
	


	visitor := MicReferenceChecker new. 
	self assert: (visitor checkFile: file ).
	file ensureDelete .
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testAllReferencesAreCorrectinDir [

	| dir file1 file2 visitor   |
	dir := (FileSystem workingDirectory / 'myDirectory') asFileReference.
   dir ensureCreateDirectory .
	
	file1 := (FileSystem workingDirectory / 'myDirectory' / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream | stream nextPutAll: '# Section 1 
		@anAnchor
		# Section 2
		@anAnchor
		 '] .
	file1 ensureCreateFile .
	
	file2 := (FileSystem workingDirectory / 'myDirectory' / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream | stream nextPutAll: ' # Section 1 
		@anAnchor'] .
   file2 ensureCreateFile . 

	visitor := MicReferenceChecker new.
	visitor checkDir: dir.
	self assert:( visitor isOk ) .
	
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection0@*

' ] .
	

	visitor := MicReferenceChecker new. 
	self deny: (visitor checkFile: file )
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAFigure [

	| doc visitor |
	doc := Microdown parse: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self assert: visitor isOk
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAFigureInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile2.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1
![alittle caption.](figures/f.png anchor=anchorSection1)

See *@anchorSection1@*

' ] .
   visitor := MicReferenceChecker new. 
	self assert: (visitor checkFile: file ).
	file ensureDelete.
]

{ #category : 'tests' }
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
	self assert: visitor isOk
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAMathEquationInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1
	
$$ %anchor=anchorSection1
balbalbalb! 
$$
See *@anchorSection1@*

' ] .
	


	visitor := MicReferenceChecker new. 
	self assert: (visitor checkFile: file).
	file ensureDelete .
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAnUknownAnchor [

	| doc visitor |
	doc := Microdown parse: '# Section 1

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOk
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReferToAnUknownAnchorInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1

See *@anchorSection1@*

' ] .
	
	
	visitor := MicReferenceChecker new. 
	self deny: (visitor checkFile: file) .
	file ensureDelete .
]

{ #category : 'tests - duplicated anchors' }
MicReferenceCheckerTest >> testReportingDuplicatedAnchors [

	| doc visitor |
	doc := Microdown parse: '# Section 
@anchorSection0

# Section 1
@anchorSection1

# Section 2
@anchorSection1

# Section 3
@anchorSection1

See *@anchorSection1@* and *@anchorSection0@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOk.
	self assert: visitor duplicatedAnchors equals: OrderedCollection <- #('anchorSection1' 'anchorSection1')
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReportingDuplicatedAnchorsInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
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
	

	visitor := MicReferenceChecker new. 
	self deny: (visitor checkFile: file).
	self assert: visitor duplicatedAnchors equals: OrderedCollection <- #('anchorSection1' 'anchorSection1') .
		file ensureDelete .
]

{ #category : 'tests - duplicated anchors' }
MicReferenceCheckerTest >> testReportingDuplicatedFigures [

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
	self deny: visitor isOk.
	self
		assert: visitor duplicatedAnchors
		equals: OrderedCollection <- #( 'anchorSection1' )
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReportingDuplicatedFiguresInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

![a caption 1](figures/f.png anchor=anchorSection1)

![a caption 2](figures/f.png anchor=anchorSection1)

![a caption 3](figures/f.png anchor=anchorSection2)

See *@anchorSection1@* and *@anchorSection3@*

'] .
	.
	visitor := MicReferenceChecker new. 
	self deny: (visitor checkFile: file) .
	self
		assert: visitor duplicatedAnchors
		equals: OrderedCollection <- #( 'anchorSection1' ) .
		
	file ensureDelete 
]

{ #category : 'tests - duplicated anchors' }
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

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection3
balbalbalb! 
$$

See *@anchorSection1@* and *@anchorSection3@*

'.
	visitor := MicReferenceChecker new.
	doc accept: visitor.
	self deny: visitor isOk.
	self
		assert: visitor duplicatedAnchors
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection1' )
]

{ #category : 'tests' }
MicReferenceCheckerTest >> testReportingDuplicatedMathsInFile [ 

	| file  visitor |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection1
balbalbalb! 
$$

$$ %anchor=anchorSection3
balbalbalb! 
$$

See *@anchorSection1@* and *@anchorSection3@*

'] .

	visitor := MicReferenceChecker new. 
   self deny: (visitor checkFile: file) .
	self
		assert: visitor duplicatedAnchors
		equals: OrderedCollection <- #( 'anchorSection1' 'anchorSection1' ).
		file ensureDelete .
]

{ #category : 'tests' }
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
	self assert: visitor unknownAnchors equals: (OrderedCollection <- #('anchorSection2'))  
]
