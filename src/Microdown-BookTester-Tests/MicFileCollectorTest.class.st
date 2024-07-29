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

{ #category : 'running' }
MicFileCollectorTest >> startVisitingFromTheRoot: root [

	"just parsing the file here and and passing it to the visitor with the fs used "
	"Note : its quite important to use parseFile: because assigning fromFile is implemented inside the parseFile: method"
	
	mainMic := Microdown parseFile: root.
	visitor := MicFileCollector new.
	visitor
		fileSystem: fs;
		visit: mainMic.
]

{ #category : 'tests' }
MicFileCollectorTest >> testEveryCaseIncluded [ 
	
	self createTestProjectEveryCaseIncluded.
	self startVisitingFromTheRoot: section2.

	self 
		assert: visitor visitedDocumentFiles
		equals: 
			{ 
				'/myDirectory/section1.md' . 
				'/myDirectory/sections/section2.md' . 
				'/myDirectory/sections/subsections/section4.md' .
				'/myDirectory/sections/subsections/subsubsections/section5.md' .
			   '/myDirectory/sections/section3.md'  
			} asSet
	
]

{ #category : 'tests - assessed' }
MicFileCollectorTest >> testFileCollectorHandlesLoopFromSection3ToMain [
	"and unknown references."
	
	self createProjectWithLoopFromSection3ToSection1.
	self startVisitingFromTheRoot: section1.
	
	"we expect
		section 1
			section2
				section3
					section1 
					section5
			section4"
	
	self 
		assert: visitor visitedDocumentFiles
		equals: 
			{ 
				'/myDirectory/section1.md' . 
				'/myDirectory/sections/section2.md' .
				'/myDirectory/sections/section4.md' .
				'/myDirectory/sections/subsections/section3.md' .
				'/myDirectory/sections/section5.md'
			} asSet.
	self 
		assert: (visitor unexistingFiles collect: [:each | each path path ])
		equals: Set <- { '/myDirectory/section6.md' } 
]

{ #category : 'tests' }
MicFileCollectorTest >> testLoopOfFilesReferencingEachOther [

	self createTestProjectSmallLoop.
	self startVisitingFromTheRoot: section1.

	self 
		assert: visitor visitedDocumentFiles
		equals: 
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' } asSet
]

{ #category : 'tests' }
MicFileCollectorTest >> testMultipleReferencesOfFileThatDoesNotExist [
	
	self createTestProjectReferencesOfFileThatDoesNotExist.
	self startVisitingFromTheRoot: section1.

	self 
		assert: visitor visitedDocumentFiles
		equals:
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicFileCollectorTest >> testMultipleReferencesToTheSameFile [
	
	self createTestProjectMultipleReferencesToTheSameFile.
	self startVisitingFromTheRoot: section1.
	
	self 
		assert: visitor visitedDocumentFiles
		equals:
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/section4.md' } asSet
	
]

{ #category : 'tests' }
MicFileCollectorTest >> testOnlyGoDownInFolders [

	self createTestProjectOnlyGoDownInFolders.
	self startVisitingFromTheRoot: section1.

	self 
		assert: visitor visitedDocumentFiles
		equals:
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]

{ #category : 'tests' }
MicFileCollectorTest >> testOnlyGoUpInFolders [
	
	self createTestProjectOnlyGoUpInFolders.
	self startVisitingFromTheRoot: section4.
	
	self 
		assert: visitor visitedDocumentFiles
		equals:
			{ '/myDirectory/section1.md'. '/myDirectory/sections/section2.md' . '/myDirectory/sections/subsections/section3.md' . '/myDirectory/sections/subsections/subsubsections/section4.md'  } asSet
	
]
