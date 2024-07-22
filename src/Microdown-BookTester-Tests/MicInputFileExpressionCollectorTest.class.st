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
		'section2'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> createTestProject [

	|  subSection1 section4 section5 |
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
<!inputFile|path=subsections/subsection1.md!>

' ].
	section4 := dir / 'sections/section4.md'.
	section4 ensureCreateFile.
	section4 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 4 
just some text  here this file does not have another reference to another file

' ].

	section5 := dir / 'sections/subsections/subsubsections/section5.md'.
	section5 ensureCreateFile.
	section5 writeStreamDo: [ :stream |
		stream nextPutAll: '# section 5
just some text  here this file does not have another reference to another file

' ].
	subSection1 := dir / 'sections/subsections/subsection1.md'.
	subSection1 ensureCreateFile.
	subSection1 writeStreamDo: [ :stream |
		stream nextPutAll: '# SubSection 1
<!inputFile|path=subsubsections/section5.md!>

' ]
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

	| mainMic  |
	self createTestProject.
	"dir resolveDocument: section1 ."
	mainMic := Microdown parse: section1 contents.
	visitor := MicInputFileExpressionCollector new .
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
]
