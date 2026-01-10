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
	file := fileSystem workingDirectory / 'mistakeInParagraph.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '# Foo
Pharo is cool.

Spec uses a sub presenter. And there is a mistake in the previous sentence.

```
	this is a code
```
' ].

	file := fileSystem workingDirectory / 'mistakeInHeader.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '## Bar
Pharo is **cool**

## sub-presenter is not correct.
```
	this is a code 2
```
' ].

	file := fileSystem workingDirectory / 'mistakeInUppercase.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '## Bar
Pharo is **cool**

sub-Presenter is not correct. The checker should pay attention that the text may use a different case than the pattern.

' ].

	file := fileSystem workingDirectory / 'mistakeInFigure.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '## Bar
Pharo is **cool**


![sub-presenter is not correct even in caption](figures/f.png)

' ]
]

{ #category : 'running' }
MicVocabularyCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicVocabularyChecker new.
	checker pairs: {
			('sub-presenter' -> 'subpresenter').
			('sub presenter' -> 'subpresenter').
			('meta object' -> 'metaobject').
			('section' -> 'Section').
			('figure' -> 'Figure').
			('back-end' -> 'backend').
			('back end' -> 'backend').
			('Pharo Image' -> 'Pharo image') }.
]

{ #category : 'running' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInFigure [

	checker checkProject: fileSystem / 'mistakeInFigure.md'.

	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-presenter is not correct even in caption" in file/mistakeInFigure.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]

{ #category : 'running' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInHeader [

	checker checkProject: fileSystem / 'mistakeInHeader.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-presenter is not correct." in file/mistakeInHeader.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]

{ #category : 'running' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInParagraph [

	checker checkProject: fileSystem / 'mistakeInParagraph.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "Spec uses a sub presenter. And there is a mistake in the previous sentence." in file/mistakeInParagraph.md contains a mistake: [sub presenter] should not be used. We should use subpresenter'
]

{ #category : 'running' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInUppercasedText [

	checker checkProject: fileSystem / 'mistakeInUppercase.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-Presenter is not correct. The checker should pay attention that the text may use a different case than the pattern." in file/mistakeInUppercase.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]
