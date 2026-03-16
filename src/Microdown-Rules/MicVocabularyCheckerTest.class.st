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

' ].

	file := fileSystem workingDirectory / 'mistakeColour.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'The colour of the sky is blue.' ].
		
	file := fileSystem workingDirectory / 'mistakeColours.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'Colours are beautiful.' ].
		
	file := fileSystem workingDirectory / 'mistakeBehaviour.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'Pharo has interesting behaviour.' ].
		
	file := fileSystem workingDirectory / 'mistakeCentre.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'The centre of the universe.' ].
		
	file := fileSystem workingDirectory / 'mistakeAllowTo.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'We allow to edit the file.' ].
		
	file := fileSystem workingDirectory / 'mistakeAllowedTo.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'You are allowed to enter.' ].
		
	file := fileSystem workingDirectory / 'mistakeAllowsTo.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'The system allows to change settings.' ].
		
	file := fileSystem workingDirectory / 'mistakeVisualise.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'We will visualise the results.' ].
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
			('Pharo Image' -> 'Pharo image').
			('colour' -> 'color').
			('colours' -> 'colors').
			('behaviour' -> 'behavior').
			('centre' -> 'center').
			('visualise' -> 'visualize').
			"Expressions"
			('allow to' -> 'allow one to').
			('allowed to' -> 'allowed one to').
			('allows to' -> 'allows one to')}.
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsAllowToMistake [

	checker checkProject: fileSystem / 'mistakeAllowTo.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "We allow to edit the file." in file/mistakeAllowTo.md contains a mistake: [allow to] should not be used. We should use allow one to'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsAllowedToMistake [
checker checkProject: fileSystem / 'mistakeAllowedTo.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "You are allowed to enter." in file/mistakeAllowedTo.md contains a mistake: [allowed to] should not be used. We should use allowed one to'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsAllowsToMistake [

	checker checkProject: fileSystem / 'mistakeAllowsTo.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "The system allows to change settings." in file/mistakeAllowsTo.md contains a mistake: [allows to] should not be used. We should use allows one to'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsBehaviourMistake [

	checker checkProject: fileSystem / 'mistakeBehaviour.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "Pharo has interesting behaviour." in file/mistakeBehaviour.md contains a mistake: [behaviour] should not be used. We should use behavior'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsCentreMistake [

	checker checkProject: fileSystem / 'mistakeCentre.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "The centre of the universe." in file/mistakeCentre.md contains a mistake: [centre] should not be used. We should use center'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsColourMistake [

	checker checkProject: fileSystem / 'mistakeColour.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "The colour of the sky is blue." in file/mistakeColour.md contains a mistake: [colour] should not be used. We should use color'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsColoursMistake [

	checker checkProject: fileSystem / 'mistakeColours.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation 
		equals:'Text: "Colours are beautiful." in file/mistakeColours.md contains a mistake: [colour] should not be used. We should use color'
		
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInFigure [

	checker checkProject: fileSystem / 'mistakeInFigure.md'.

	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-presenter is not correct even in caption" in file/mistakeInFigure.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInHeader [

	checker checkProject: fileSystem / 'mistakeInHeader.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-presenter is not correct." in file/mistakeInHeader.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInParagraph [

	checker checkProject: fileSystem / 'mistakeInParagraph.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "Spec uses a sub presenter. And there is a mistake in the previous sentence." in file/mistakeInParagraph.md contains a mistake: [sub presenter] should not be used. We should use subpresenter'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsMistakeInUppercasedText [

	checker checkProject: fileSystem / 'mistakeInUppercase.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "sub-Presenter is not correct. The checker should pay attention that the text may use a different case than the pattern." in file/mistakeInUppercase.md contains a mistake: [sub-presenter] should not be used. We should use subpresenter'
]

{ #category : 'tests' }
MicVocabularyCheckerTest >> testCheckerFindsVisualiseMistake [

	checker checkProject: fileSystem / 'mistakeVisualise.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'Text: "We will visualise the results." in file/mistakeVisualise.md contains a mistake: [visualise] should not be used. We should use visualize'
]
