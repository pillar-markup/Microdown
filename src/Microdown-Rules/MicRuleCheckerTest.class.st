Class {
	#name : 'MicRuleCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'ck'
	],
	#category : 'Microdown-Rules-Old',
	#package : 'Microdown-Rules',
	#tag : 'Old'
}

{ #category : 'tests' }
MicRuleCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'example1WithMistake.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

Spec uses a sub presenter
```
	this is a code
```
' ].

	file := fileSystem workingDirectory / 'example2WithMistake.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '## Bar
Pharo is **cool**

sub-presenter is not correct.
```
	this is a code 2
```
' ]
]

{ #category : 'tests' }
MicRuleCheckerTest >> setUp [ 
	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	
	ck := MicRuleAllTextChecker new. 
	ck addRule: MicMisusedVocabularyRule sample.
	ck prepareForChecking.
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerExplain [

	| doc |	
	doc := Microdown parseFile: (fileSystem / 'example1WithMistake.md').
	ck visit: doc.

	self 
		assert: ck errors first explain 
		equals: 'Text: Spec uses a sub presenter in file/example1WithMistake.md contains a mistake: *sub presenter*should not be used. We should use subpresenter'

]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindFigureMistackeInParagraph [

	| doc |
	doc := Microdown parse:
		       'In this manual, we will first explain the basic concepts before diving into the advanced mechanisms. As described in figure 1.1, it is important to understand how each component interacts with the others to ensure the proper functioning of the system.'.
	ck visit: doc.
	self assert: ck errors size equals: 1
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindFigureMistackeInTitle [

	| doc |
	doc := Microdown parse: '# figure 1.1'.
	ck visit: doc.
	self assert: ck errors size equals: 1
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindOneMistakeInFile [

	| doc |
	
	doc := Microdown parseFile: (fileSystem / 'example1WithMistake.md').
	ck visit: doc.
	self assert: ck errors size equals: 1.
	self assert: ck errors first inFile equals: (fileSystem / 'example1WithMistake.md').
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindOneMistakeInHeader [

	| doc |
	doc := Microdown parse: '# the sub presenter.'.
	ck visit: doc.
	self assert: ck errors size equals: 1.
	
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindOneMistakeInParagraph [

	| doc |
	
	doc := Microdown parse: 'this is text with a mistake: sub presenter should not be used.'.
	ck visit: doc.
	self assert: ck errors size equals: 1

]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindSectionMistackeInParagraph [

	| doc |
	doc := Microdown parse:
		       'In this manual, we will first explain the basic concepts before diving into the advanced mechanisms. As described in section 1.1, it is important to understand how each component interacts with the others to ensure the proper functioning of the system.'.
	ck visit: doc.
	self assert: ck errors size equals: 1
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindSectionMistackeInTitle [

	| doc |
	doc := Microdown parse: '# section 1.1'.
	ck visit: doc.
	self assert: ck errors size equals: 1
]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerPrepare [

	| r |
	ck := MicRuleAllTextChecker new.
	r := MicMisusedVocabularyRule sample.
	ck addRule: MicMisusedVocabularyRule sample.
	ck prepareForChecking.
	self
		assert: (ck patterns collect: [ :p | p key ])
		equals:
		#( '*sub-presenter*' '*sub presenter*' '*meta object*' '*section*' '*figure*' '*back-end*' '*back end*' '*Pharo Image*' )
]

{ #category : 'tests' }
MicRuleCheckerTest >> testFile [
	| filecontents |
	filecontents := (fileSystem / 'example1WithMistake.md') readStream contents.
	self assert: filecontents size equals: 71
	
]

{ #category : 'tests' }
MicRuleCheckerTest >> testGoodWord [

	self
		assert: (ck patterns collect: [ :p | p key ]) 
		equals: #('*sub-presenter*' '*sub presenter*' '*meta object*' '*section*' '*figure*' '*back-end*' '*back end*' '*Pharo Image*')
	
]
