Class {
	#name : 'MicExerciseHiderTest',
	#superclass : 'TestCase',
	#instVars : [
		'testFolder',
		'testFile',
		'visitor'
	],
	#category : 'Microdown-ExerciseHider',
	#package : 'Microdown-ExerciseHider'
}

{ #category : 'running' }
MicExerciseHiderTest >> setUp [
	super setUp.
	testFolder := FileSystem memory / 'Chapter1'.
	testFolder ensureCreateDirectory.
	testFile := testFolder / 'File1.md'
]

{ #category : 'tests' }
MicExerciseHiderTest >> tests"
testChapterNumber [
	visitor chapterNumber: '3'.
	self assert: visitor chapterNumber equals: '3'
]

{ #category : 'tests' }
MicExerciseHiderTest >> testContentsGeneratesSolution [
	| document |
	visitor chapterNumber: '2'.
	document := MicrodownParser parse: '```exercise&anchor=exfoo
Foo >> bar
my code
````'.
	visitor visit: document.
	self assert: (visitor contents includesSubstring: '*@exfoo@*').
	self assert: (visitor contents includesSubstring: '*@Chap2@*').
	self assert: (visitor contents includesSubstring: 'my code')
]

{ #category : 'tests' }
MicExerciseHiderTest >> testExtractChapterNumber [
	| extractor |
	extractor := MicExerciseSolutionGenerator new sourceFile: testFile.
	extractor extractChapterNumber.
	self assert: extractor chapterNumber equals: '1'
]

{ #category : 'tests' }
MicExerciseHiderTest >> testFullProcess [
	| extractor |
	testFile writeStreamDo: [:s | s nextPutAll: '```exercise&anchor=exfoo
Foo >> bar
some code
```'].
	extractor := MicExerciseSolutionGenerator new sourceFile: testFile.
	extractor process.
	self assert: (testFile contents includesSubstring: '## Chapt').
	self assert: (testFile contents includesSubstring: 'Foo >> bar').
	self deny: (testFile contents includesSubstring: 'some code').
	self assert: (testFolder / 'File1Solutions.md') exists
]

{ #category : 'tests' }
MicExerciseHiderTest >> testWithIndentedCodeBlock [
	| extractor |
	testFile writeStreamDo: [:s | s nextPutAll: '    ```exercise&anchor=exfoo
Foo >> bar
code
```'].
	extractor := MicExerciseSolutionGenerator new sourceFile: testFile.
	extractor process.
	self assert: (testFile contents includesSubstring: 'Foo >> bar').
	self assert: (testFolder / 'File1Solutions.md') contents isNotEmpty
]
