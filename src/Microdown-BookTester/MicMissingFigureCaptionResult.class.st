Class {
	#name : 'MicMissingFigureCaptionResult',
	#superclass : 'MicResult',
	#instVars : [
		'figure'
	],
	#category : 'Microdown-BookTester-Checker-EmptyCaption',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-EmptyCaption'
}

{ #category : 'accessing' }
MicMissingFigureCaptionResult >> figure [
	^ figure
]

{ #category : 'accessing' }
MicMissingFigureCaptionResult >> figure: aFigure [
	figure := aFigure
]
