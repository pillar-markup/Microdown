Class {
	#name : 'MicInputFileExpressionCollectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'fs',
		'dir',
		'main',
		'section1',
		'visitor',
		'collector',
		'section2',
		'section3',
		'section4',
		'section5',
		'mainMic'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProject [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section4.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=./subsections/section3.md!>



' ].
	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
just some text  here this file does not have another reference to another file

' ].

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../../section1.md!>
<!inputFile|path=../section5.md!>

' ].
	section5 := dir / 'sections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5
<!inputFile|path=../section6.md!>

' ]



]

{ #category : 'full project cheking tests' }
MicInputFileExpressionCollectorTest >> createTestProjectBadAndCorrectReferences [

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
		stream nextPutAll: '
 See *@anchorSection1@* and *@anchorSection2@*
	
<!inputFile|path=subsections/section3.md!>



' ].



]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectEveryCaseIncluded [ 

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section3.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=subsections/section4.md!>



' ].

	section3 := dir / 'sections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../section1.md!>


' ].
	section4 := dir / 'sections/subsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=subsubsections/section5.md!>

' ].


	section5 := dir / 'sections/subsections/subsubsections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5
<!inputFile|path=../section6.md!>
<!inputFile|path=../../section3.md!>

' ]



]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectMultipleReferencesToTheSameFile [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section4.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2

<!inputFile|path=../section1.md!>



' ].
	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=../section1.md!> 

' ]

	


]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectOnlyGoDownInFolders [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

<!inputFile|path=sections/section2.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=subsections/section3.md!>



' ].

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=subsubsections/section4.md!>

' ].



	section4 := dir / 'sections/subsections/subsubsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
 

' ]




]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectOnlyGoUpInFolders [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

just text here
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=../section1.md!>



' ].

	section3 := dir / 'sections/subsections/section3.md'.
	section3 ensureCreateFile.
	section3 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 3
<!inputFile|path=../section2.md!>

' ].



	section4 := dir / 'sections/subsections/subsubsections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=../section3.md!>
 

' ]




]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectReferencesOfFileThatDoesNotExist [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1
		
<!inputFile|path=sections/section2.md!>
<!inputFile|path=sections/section3.md!>
<!inputFile|path=sections/section4.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=./subsections/section3.md!>



' ].
	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
<!inputFile|path=./subsections/section5.md!>

' ]


]

{ #category : 'project creation' }
MicInputFileExpressionCollectorTest >> createTestProjectSmallLoop [

	section1 := dir / 'section1.md'.
	section1 ensureCreateFile.
	section1 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section1

<!inputFile|path=sections/section2.md!>
' ].

	section2 := dir / 'sections/section2.md'.
	section2 ensureCreateFile.
	section2 writeStreamDo: [ :stream |
		stream nextPutAll: '# Section 2
<!inputFile|path=../section1.md!>



' ]
	

]

{ #category : 'utils' }
MicInputFileExpressionCollectorTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'utils' }
MicInputFileExpressionCollectorTest >> setUp [

	super setUp.
	fs := self fileSystem.
	dir := (fs / 'myDirectory') asFileReference.
	dir ensureCreateDirectory .
	visitor := MicInputFileExpressionCollector new .
]

{ #category : 'utils' }
MicInputFileExpressionCollectorTest >> startVisitingFromTheRoot: root [

	"just parsing the file here and and passing it to the visitor with the fs used "
	"Note : its quite important to use parseFile: because assigning fromFile is implemented inside the parseFile: method 
	For Example using 'Microdown Parse: File Content' directly then passing it to the visitor  can cause problems  "
	
	mainMic := Microdown parseFile: root.
	visitor := MicFilesCollector new.
	visitor
		fileSystem: fs;
		visit: mainMic.
]

{ #category : 'full project cheking tests' }
MicInputFileExpressionCollectorTest >> test [
   

	| checker |
	self createTestProjectBadAndCorrectReferences .
	checker := MicReferenceChecker new . 
	self deny: ( checker checkProject: section1 fileSystem: fs) .
	
]

{ #category : 'implenation 2 Tests' }
MicInputFileExpressionCollectorTest >> testAllFilesReferencesStartingFromTheButtomV2Implementation [

"this is for testing the other implementation ( 3 only because the root file is not added automatically but that can be easily managed because wee need to have the file reference anyway )
and in this test we start in a file in the buttom of the folders and go up  "


	self createTestProjectOnlyGoUpInFolders .
	mainMic := Microdown parseFile: section4 . 
	dir := (fs / 'myDirectory'/'sections/subsections/subsubsections/section4.md') asFileReference.
	
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 3 
]

{ #category : 'implenation 2 Tests' }
MicInputFileExpressionCollectorTest >> testAllFilesV2Implementation [

"this is for testing the other implementation ( 3 only because the root file is not added automatically but that can be easily managed because wee need to have the file reference anyway ) "


	self createTestProjectOnlyGoDownInFolders .
	mainMic := Microdown parseFile: section1 .
	dir := (fs / 'myDirectory'/'section1.md') asFileReference.
	
	
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 3 
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testCollectReference [

	
	"preparation of project and passing the parsed root to the visitor "
	self createTestProject.
	self startVisitingFromTheRoot: section1 .
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md'.
			'/myDirectory/sections/section4.md'.
			'/myDirectory/sections/subsections/section3.md' .
			'/myDirectory/sections/section5.md'} asSet
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testEveryCaseIncluded [ 
	

   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectEveryCaseIncluded .
	self startVisitingFromTheRoot: section2 .

	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section4.md' . '/myDirectory/sections/subsections/subsubsections/section5.md' .
			'/myDirectory/sections/section3.md'  } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testLoopOfFilesReferencingEachOther [

   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectSmallLoop .
	self startVisitingFromTheRoot: section1 .

	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' } asSet
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testMultipleReferencesOfFileThatDoesNotExist [
	
	
   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectReferencesOfFileThatDoesNotExist .
	self startVisitingFromTheRoot: section1 .
	
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testMultipleReferencesToTheSameFile [
	
	
	
   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectMultipleReferencesToTheSameFile .
	self startVisitingFromTheRoot: section1 .
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testOnlyGoDownInFolders [


   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectOnlyGoDownInFolders .
	self startVisitingFromTheRoot: section1 .

	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testOnlyGoUpInFolders [
	
   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectOnlyGoUpInFolders .
	self startVisitingFromTheRoot: section4 .
	
   "assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]
