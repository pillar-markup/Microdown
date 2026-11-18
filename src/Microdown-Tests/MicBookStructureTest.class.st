"
I test `MicBookStructure`: the roles it gives to header levels, its defaults, the structures it refuses, and how a `MicRootBlock` answers its structure.
"
Class {
	#name : 'MicBookStructureTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests',
	#package : 'Microdown-Tests'
}

{ #category : 'helpers' }
MicBookStructureTest >> headerOfLevel: anInteger [

	^ MicHeaderBlock new
		  level: anInteger;
		  yourself
]

{ #category : 'helpers' }
MicBookStructureTest >> rolesIn: aStructure [
	"The role aStructure gives to each header level, from # to ######."

	^ (1 to: 6) collect: [ :each |
		  aStructure roleOf: (self headerOfLevel: each) ]
]

{ #category : 'tests - errors' }
MicBookStructureTest >> testChapterLevelZeroRaisesError [

	self
		should: [ MicBookStructure chapterLevel: 0 paragraphLevel: 4 ]
		raise: MicInvalidBookStructure
]

{ #category : 'tests - roles' }
MicBookStructureTest >> testDefaultLevels [

	| structure |
	structure := MicBookStructure new.

	self assert: structure chapterLevel equals: 2.
	self assert: structure paragraphLevel equals: 5
]

{ #category : 'tests - errors' }
MicBookStructureTest >> testFourSectionLevelsRaiseError [

	self
		should: [ MicBookStructure chapterLevel: 1 paragraphLevel: 6 ]
		raise: MicInvalidBookStructure
]

{ #category : 'tests - numbers and toc' }
MicBookStructureTest >> testNumbersFollowTheChapterLevel [

	| structure |
	structure := MicBookStructure chapterLevel: 1 paragraphLevel: 4.

	self
		assert: ((1 to: 6) collect: [ :each |
				 structure isNumbered: (self headerOfLevel: each) ])
		equals: #( true true false false false false )
]

{ #category : 'tests - numbers and toc' }
MicBookStructureTest >> testOnlyChaptersAndSectionsAreNumbered [

	| structure |
	structure := MicBookStructure new.

	self
		assert: ((1 to: 6) collect: [ :each |
				 structure isNumbered: (self headerOfLevel: each) ])
		equals: #( false true true false false false )
]

{ #category : 'tests - errors' }
MicBookStructureTest >> testParagraphLevelBeyondSixRaisesError [

	self
		should: [ MicBookStructure chapterLevel: 3 paragraphLevel: 7 ]
		raise: MicInvalidBookStructure
]

{ #category : 'tests - errors' }
MicBookStructureTest >> testParagraphLevelNotDeeperThanChaptersRaisesError [

	self
		should: [ MicBookStructure chapterLevel: 2 paragraphLevel: 2 ]
		raise: MicInvalidBookStructure
]

{ #category : 'tests - roles' }
MicBookStructureTest >> testPredicates [

	| structure |
	structure := MicBookStructure new.

	self assert: (structure isPart: (self headerOfLevel: 1)).
	self assert: (structure isChapter: (self headerOfLevel: 2)).
	self assert: (structure isSection: (self headerOfLevel: 4)).
	self assert: (structure isParagraph: (self headerOfLevel: 6)).
	self deny: (structure isSection: (self headerOfLevel: 5))
]

{ #category : 'tests - roles' }
MicBookStructureTest >> testRolesOfTheDefaultStructure [

	self
		assert: (self rolesIn: MicBookStructure new)
		equals: #( #part #chapter #section #section #paragraph #paragraph )
]

{ #category : 'tests - roles' }
MicBookStructureTest >> testRolesWithChaptersAtLevelOne [

	self
		assert:
		(self rolesIn: (MicBookStructure chapterLevel: 1 paragraphLevel: 4))
		equals:
		#( #chapter #section #section #paragraph #paragraph #paragraph )
]

{ #category : 'tests - root' }
MicBookStructureTest >> testRootAnswersItsStructure [

	| root structure |
	root := Microdown parse: '# Title'.
	structure := MicBookStructure chapterLevel: 1 paragraphLevel: 4.

	root bookStructure: structure.

	self assert: root bookStructure identicalTo: structure
]

{ #category : 'tests - root' }
MicBookStructureTest >> testRootAnswersTheDefaultStructure [

	| structure |
	structure := (Microdown parse: '# Title') bookStructure.

	self assert: structure chapterLevel equals: 2.
	self assert: structure paragraphLevel equals: 5
]

{ #category : 'tests - roles' }
MicBookStructureTest >> testSectionDepth [

	| structure |
	structure := MicBookStructure new.

	self
		assert: (structure sectionDepthOf: (self headerOfLevel: 3))
		equals: 1.
	self
		assert: (structure sectionDepthOf: (self headerOfLevel: 4))
		equals: 2
]

{ #category : 'tests - numbers and toc' }
MicBookStructureTest >> testTocListsPartsChaptersAndSections [

	| structure |
	structure := MicBookStructure new.

	self
		assert: ((1 to: 6) collect: [ :each |
				 structure isInToc: (self headerOfLevel: each) ])
		equals: #( true true true false false false )
]
