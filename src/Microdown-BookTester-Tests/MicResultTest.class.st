Class {
	#name : 'MicResultTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicResultTest >> testAllReferencesAreCorrect [

	| doc visitor |
	doc := Microdown parse:	'# Section 1
@anchorSection1

See *@anchorSection1@*

'.
	visitor := MicReferenceChecker new. 
	doc accept: visitor. 
	self assert: visitor isOk
]

{ #category : 'tests' }
MicResultTest >> testAllReferencesAreCorrectInFile [ 

	| file  visitor |
	file := (FileSystem memory / 'myFile.txt') asFileReference.
   file ensureCreateFile.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Section 1
@anchorSection1

See *@anchorSection1@*

' ] .
	


	visitor := MicReferenceChecker new. 
	visitor checkFile: file .
	self assert: (visitor checkFile: file ).
	file ensureDelete 
]

{ #category : 'tests' }
MicResultTest >> testAllReferencesAreCorrectinDir [

	| dir file1 file2 visitor |
	dir := (FileSystem workingDirectory / 'myDirectory') asFileReference.
   dir ensureCreateDirectory.
	file1 := (FileSystem workingDirectory / 'myDirectory' / 'file1.txt') asFileReference.
	file1 writeStreamDo: [ :stream | stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1

' ] .
	
	file2 := (FileSystem workingDirectory / 'myDirectory' / 'file2.txt') asFileReference.
	file2 writeStreamDo: [ :stream | stream nextPutAll: ' See *@anchorSection1@*   '] .
   file2 ensureCreateFile. 

	visitor := MicReferenceChecker new.
	visitor checkDirectory: dir .
	self assert: (visitor checkDirectory: dir).
	
]

{ #category : 'tests' }
MicResultTest >> testErrorAnchorIsMissing [

	| doc validator |
	doc := Microdown parse: '# Section 
@anchorSection0

# Section 1
@anchorSection1

See *@anchorSection1@* and *@anchorSection2@* and *@anchorSection2@* and *@anchorSection3@*

'.
	validator := MicReferenceChecker new.
	doc accept: validator .
	self assert: validator isFailure .
	self assert: validator allTestsResults first explanation equals: ( MicResult allMessages at: #anchorIsMissing).
	self assert: validator allTestsResults first specification equals: 'anchorSection2'
	
]
