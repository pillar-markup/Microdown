Class {
	#name : 'MicVocabularyCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-Vocabulary',
	#package : 'Microdown-Rules',
	#tag : 'Vocabulary'
}

{ #category : 'running' }
MicVocabularyCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'example1WithMistake.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '# Foo
Pharo is cool

Spec uses a sub presenter
```
	this is a code
```
' ].

	file := fileSystem workingDirectory / 'example2WithMistake.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '## Bar
Pharo is **cool**

sub-presenter is not correct.
```
	this is a code 2
```
' ]
]

{ #category : 'running' }
MicVocabularyCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicVocabularyChecker new. 
		
	
]

{ #category : 'running' }
MicVocabularyCheckerTest >> testCheckerExplain [

	checker pairs: {
			('sub-presenter' -> 'subpresenter').
			('sub presenter' -> 'subpresenter').
			('meta object' -> 'metaobject').
			('section' -> 'Section').
			('figure' -> 'Figure').
			('back-end' -> 'backend').
			('back end' -> 'backend').
			('Pharo Image' -> 'Pharo image') }.

	checker checkProject: fileSystem / 'example1WithMistake.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: Spec uses a sub presenter in file/example1WithMistake.md contains a mistake: [sub presenter] should not be used. We should use subpresenter'
]
