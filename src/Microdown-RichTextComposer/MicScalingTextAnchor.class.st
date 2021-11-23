Class {
	#name : #MicScalingTextAnchor,
	#superclass : #TextAnchor,
	#instVars : [
		'original',
		'scale'
	],
	#category : #'Microdown-RichTextComposer'
}

{ #category : #accessing }
MicScalingTextAnchor >> anchoredMorph [ 
	^ super anchoredMorph 
]

{ #category : #accessing }
MicScalingTextAnchor >> original [

	^ original
]

{ #category : #accessing }
MicScalingTextAnchor >> original: aForm [

	original := aForm.
	anchoredMorph := aForm
]

{ #category : #accessing }
MicScalingTextAnchor >> scale: percentOrNil [
	scale := percentOrNil 
]

{ #category : #accessing }
MicScalingTextAnchor >> targetWidth: rightMargin [
	|newWidth newHeight|
	newWidth := rightMargin  / 100 * scale.
	newHeight := original  height / original width * newWidth.
	"This will fail when given a morph, only works for forms"
	anchoredMorph isMorph
		ifTrue: [ anchoredMorph := original extent: newWidth @ newHeight]
		ifFalse:[ anchoredMorph  := original scaledToSize: newWidth @ newHeight]
]
