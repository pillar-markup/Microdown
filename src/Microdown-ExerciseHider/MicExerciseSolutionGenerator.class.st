Class {
	#name : 'MicExerciseSolutionGenerator',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'exercises',
		'builder',
		'chapterNumber'
	],
	#category : 'Microdown-ExerciseHider',
	#package : 'Microdown-ExerciseHider'
}

{ #category : 'accessing' }
MicExerciseSolutionGenerator >> chapterNumber [

	^ chapterNumber
]

{ #category : 'accessing' }
MicExerciseSolutionGenerator >> chapterNumber: anObject [

	chapterNumber := anObject
]

{ #category : 'accessing' }
MicExerciseSolutionGenerator >> contents [
	exercises do: [:ex | self writeSolution: ex].
	^ builder contents
]

{ #category : 'accessing' }
MicExerciseSolutionGenerator >> exercises [

	^ exercises
]

{ #category : 'accessing' }
MicExerciseSolutionGenerator >> exercises: anObject [

	exercises := anObject
]

{ #category : 'initialization' }
MicExerciseSolutionGenerator >> initialize [
	super initialize.
	builder := MicMicrodownTextualBuilder new.
	exercises := OrderedCollection new
]

{ #category : 'visiting' }
MicExerciseSolutionGenerator >> visitCode: aCodeBlock [
	| anchor |
	(aCodeBlock arguments includesKey: #exercise) ifFalse: [ ^ self ].
	anchor := aCodeBlock anchor.
	anchor ifNotNil: [
			exercises add: {
					anchor.
					aCodeBlock body } ]
]

{ #category : 'initialization' }
MicExerciseSolutionGenerator >> writeSolution: exercise [
	| anchor code |
	anchor := exercise first.
	code := exercise second.
	builder 
		line: 'Here is the solution of the code *@', anchor, '@* in Chapter *@Chap', chapterNumber, '@*';
		raw: '```';
		newLine;
		newLine;
		rawLines: code;
		newLine;
		raw: '```';
		newLine
]
