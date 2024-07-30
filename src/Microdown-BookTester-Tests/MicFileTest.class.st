Class {
	#name : 'MicFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'dir',
		'section1',
		'section2',
		'section3',
		'section4',
		'section5',
		'fs'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'project creation' }
MicFileTest >> createProjectOnlyGoDownInFolders [

	self section1InputsSection2.
	self section2InputsNestedSection3.
	self section3InputsNestedSection4.
	self section4IsLeaf
]

{ #category : 'project creation' }
MicFileTest >> createProjectOnlyGoUpInFolders [

	self section1IsLeaf.
	self section2InputsSection1.
	self section3InputsParentSection2.
	self section4InputsParentSection3
]

{ #category : 'project creation' }
MicFileTest >> createProjectWithLoopFromSection3ToSection1 [

	self section1InputsSection2And4.
	self section2InputsSection3.
	self section4DoesNotInputFile.
	self section3InputsSection1And5.
	self section5InputFileUndefinedSection6
]

{ #category : 'project creation' }
MicFileTest >> createProjectWithUnexistingSection3And5 [

	self section1InputSection2And4AndUnexisting3.
	self section2InputsSection3.
	self section4InputsUnexistingSection5
]

{ #category : 'project creation' }
MicFileTest >> createProjectWithUnreferencedFile [

	self section1InputsSection2And4.
	
	self section4IsLeaf
]

{ #category : 'project creation' }
MicFileTest >> createProjectWithUnreferencedFiles3And5 [

	self section1InputsSection2And4.
	self section2InputsSection4InAnotherPosition.
	self section3IsLeaf.
	self section4IsLeafInAnotherPosition.
	self section5IsLeaf
]

{ #category : 'project creation' }
MicFileTest >> createTestDoubleLoop3To1And5To3 [

	self section1InputsSection2And3.
	self section2InputsSection4.
	self section3InputsSection1Loop.
	self section4InputsSection5.
	self section5InpsutsUnknowSection6AndLoopOverSection3
]

{ #category : 'project creation' }
MicFileTest >> createTestProjectBadAndCorrectReferences [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 
@anchorSection0

# Section 1
@anchorSection1
<!inputFile|path=sections/section2.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: ' See *@anchorSection1@* and *@anchorSection2@*	
<!inputFile|path=subsections/section3.md!>
' ].



]

{ #category : 'project creation' }
MicFileTest >> createTestProjectSmallLoop [

	self section1InputsSection2.
	self section2InputsSection1
]

{ #category : 'project creation' }
MicFileTest >> createUndirectCyclesToTheSameFile [

	self section1InputsSection2And4.
	self section2InputsSection1.
	self section4InputsSection1
]

{ #category : 'accessing' }
MicFileTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'helpers' }
MicFileTest >> section1InputSection2And4AndUnexisting3 [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section3.md!>
<!inputFile|path=sections/section4.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section1InputsSection2 [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
<!inputFile|path=sections/section2.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section1InputsSection2And3 [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section3.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section1InputsSection2And4 [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section4.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section1IsLeaf [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
just text here
' ]
]

{ #category : 'project creation' }
MicFileTest >> section2InputsNestedSection3 [

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=subsections/section3.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section2InputsSection1 [

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=../section1.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section2InputsSection3 [

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=./subsections/section3.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section2InputsSection4 [

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=subsections/section4.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section2InputsSection4InAnotherPosition [

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=sections/section4.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section3InputsNestedSection4 [

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=subsubsections/section4.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section3InputsParentSection2 [

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../section2.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section3InputsSection1And5 [

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../../section1.md!>
<!inputFile|path=../section5.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section3InputsSection1Loop [

	section3 := dir / 'sections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../section1.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section3IsLeaf [

	section3 := dir / 'sections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3 
' ]
]

{ #category : 'helpers' }
MicFileTest >> section4DoesNotInputFile [

	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
just some text  here this file does not have another reference to another file
' ]
]

{ #category : 'project creation' }
MicFileTest >> section4InputsParentSection3 [

	section4 := dir / 'sections/subsections/subsubsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=../section3.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section4InputsSection1 [

	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=../section1.md!> 
' ]
]

{ #category : 'helpers' }
MicFileTest >> section4InputsSection5 [

	section4 := dir / 'sections/subsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=subsubsections/section5.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section4InputsUnexistingSection5 [

	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=./subsections/section5.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section4IsLeaf [

	section4 := dir / 'sections/subsections/subsubsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
' ]
]

{ #category : 'project creation' }
MicFileTest >> section4IsLeafInAnotherPosition [

	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
' ]
]

{ #category : 'helpers' }
MicFileTest >> section5InpsutsUnknowSection6AndLoopOverSection3 [

	section5 := dir / 'sections/subsections/subsubsections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5
<!inputFile|path=../section6.md!>
<!inputFile|path=../../section3.md!>
' ]
]

{ #category : 'helpers' }
MicFileTest >> section5InputFileUndefinedSection6 [

	section5 := dir / 'sections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5
<!inputFile|path=../section6.md!>
' ]
]

{ #category : 'project creation' }
MicFileTest >> section5IsLeaf [

	section5 := dir / 'sections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5 
' ]
]

{ #category : 'running' }
MicFileTest >> setUp [

	super setUp.
	fs := self fileSystem.
	dir := fs / 'myDirectory'.
	dir ensureCreateDirectory.
]
