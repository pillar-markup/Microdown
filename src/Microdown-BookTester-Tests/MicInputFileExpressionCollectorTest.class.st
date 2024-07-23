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

{ #category : 'tests' }
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

' ].



]

{ #category : 'tests' }
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

' ].



]

{ #category : 'tests' }
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

' ].

	


]

{ #category : 'tests' }
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
 

' ].




]

{ #category : 'tests' }
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
 

' ].




]

{ #category : 'tests' }
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

' ].


]

{ #category : 'tests' }
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



' ].
	

]

{ #category : 'accessing' }
MicInputFileExpressionCollectorTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'running' }
MicInputFileExpressionCollectorTest >> setUp [

	super setUp.
	fs := self fileSystem.
	dir := (fs / 'myDirectory') asFileReference.
	dir ensureCreateDirectory .
	visitor := MicInputFileExpressionCollector new .
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testAllFilesReferences [

	| mainMic  |
	self createTestProject.
	"dir resolveDocument: section1 ."
	mainMic := Microdown parse: section1 contents.
	visitor := MicInputFileExpressionCollector new .
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 4 .
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testAllFilesReferencesStartingFromASdubBranch [

	| mainMic  |
	self createTestProject.
	"dir resolveDocument: section1 ."
	mainMic := Microdown parse: section2 contents.
	dir := (fs / 'myDirectory'/'sections/section2.md') asFileReference.
	visitor := MicInputFileExpressionCollector new .
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 2 .
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testCollectReference [

	self createTestProject.
	"dir resolveDocument: section1 ."
	mainMic := Microdown parseFile: section1.
	visitor := MicFilesCollector new.
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
1halt.
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md'.
			'/myDirectory/sections/section4.md'.
			'/myDirectory/sections/subsections/section3.md' .
			'/myDirectory/sections/section5.md'} asSet
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testEveryCaseIncluded [ 
	

	"preparation"
	self createTestProjectEveryCaseIncluded .
	mainMic := Microdown parseFile: section2 .
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	self halt .
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section4.md' . '/myDirectory/sections/subsections/subsubsections/section5.md' .
			'/myDirectory/sections/section3.md'  } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testLoopOfFilesReferencingEachOther [

	"preparation"
	self createTestProjectSmallLoop .
	mainMic := Microdown parseFile: section1.
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' } asSet
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testMultipleReferencesOfFileThatDoesNotExist [
	
	
	"preparation"
	self createTestProjectReferencesOfFileThatDoesNotExist .
	mainMic := Microdown parseFile: section1.
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testMultipleReferencesToTheSameFile [
	
	
	"preparation"
	self createTestProjectMultipleReferencesToTheSameFile .
	mainMic := Microdown parseFile: section1.
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testOnlyGoDownInFolders [

	"preparation"
	self createTestProjectOnlyGoDownInFolders .
	mainMic := Microdown parseFile: section1.
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testOnlyGoUpInFolders [
	
		"preparation"
	self createTestProjectOnlyGoUpInFolders .
	mainMic := Microdown parseFile: section4.
	visitor := MicFilesCollector new.
	
	"visiting "
	visitor
		fileSystem: fs;
		visit: mainMic.
	visitor visited.
	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]
