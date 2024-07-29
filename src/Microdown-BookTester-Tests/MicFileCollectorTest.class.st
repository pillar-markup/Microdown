Class {
	#name : 'MicFileCollectorTest',
	#superclass : 'MicFileTest',
	#instVars : [
		'mainMic',
		'visitor'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'utils' }
MicFileCollectorTest >> startVisitingFromTheRoot: root [

	"just parsing the file here and and passing it to the visitor with the fs used "
	"Note : its quite important to use parseFile: because assigning fromFile is implemented inside the parseFile: method"
	
	mainMic := Microdown parseFile: root.
	visitor := MicFilesCollector new.
	visitor
		fileSystem: fs;
		visit: mainMic.
]

{ #category : 'utils' }
MicFileCollectorTest >> testCollectReference [

	self createTestProject.
	self startVisitingFromTheRoot: section1.
	
	self 
		assert: visitor visited
		equals: 
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md'.
			'/myDirectory/sections/section4.md'.
			'/myDirectory/sections/subsections/section3.md' .
			'/myDirectory/sections/section5.md'} asSet
]

{ #category : 'utils' }
MicFileCollectorTest >> testEveryCaseIncluded [ 
	

   "preparation of project and passing the parsed root to the visitor "
	self createTestProjectEveryCaseIncluded .
	self startVisitingFromTheRoot: section2 .

	"assertion"
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section4.md' . '/myDirectory/sections/subsections/subsubsections/section5.md' .
			'/myDirectory/sections/section3.md'  } asSet
	
]

{ #category : 'utils' }
MicFileCollectorTest >> testLoopOfFilesReferencingEachOther [

	self createTestProjectSmallLoop.
	self startVisitingFromTheRoot: section1.

	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' } asSet
]

{ #category : 'utils' }
MicFileCollectorTest >> testMultipleReferencesOfFileThatDoesNotExist [
	
	self createTestProjectReferencesOfFileThatDoesNotExist.
	self startVisitingFromTheRoot: section1.

	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'utils' }
MicFileCollectorTest >> testMultipleReferencesToTheSameFile [
	
	self createTestProjectMultipleReferencesToTheSameFile.
	self startVisitingFromTheRoot: section1.
	
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'utils' }
MicFileCollectorTest >> testOnlyGoDownInFolders [

	self createTestProjectOnlyGoDownInFolders.
	self startVisitingFromTheRoot: section1.

	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]

{ #category : 'utils' }
MicFileCollectorTest >> testOnlyGoUpInFolders [
	
	self createTestProjectOnlyGoUpInFolders .
	self startVisitingFromTheRoot: section4 .
	
	self assert: visitor visited
		=
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]
