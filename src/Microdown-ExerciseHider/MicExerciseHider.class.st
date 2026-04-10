Class {
	#name : 'MicExerciseHider',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'sourceFile',
		'chapterNumber'
	],
	#category : 'Microdown-ExerciseHider',
	#package : 'Microdown-ExerciseHider'
}

{ #category : 'utils' }
MicExerciseHider >> hideExercises [
	| document studentVisitor solutionVisitor cleanedContent |
	self extractChapterNumber.
	cleanedContent := self removeIndentationFromCodeBlocks: sourceFile contents.
	document := MicrodownParser parse: cleanedContent.
	studentVisitor := MicExerciseStudentBodyGenerator new chapterNumber: chapterNumber.
	solutionVisitor := MicExerciseSolutionGenerator new chapterNumber: chapterNumber.
	studentVisitor visit: document.
	solutionVisitor visit: document.
	self writeFile: sourceFile basename content: studentVisitor contents.
	self writeFile: (sourceFile basenameWithoutExtension, 'Solutions.md') content: solutionVisitor contents
]
