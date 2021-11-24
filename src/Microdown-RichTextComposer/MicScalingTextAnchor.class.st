Class {
	#name : #MicScalingTextAnchor,
	#superclass : #TextAnchor,
	#instVars : [
		'original',
		'scale',
		'freezeHeight'
	],
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #accessing }
MicScalingTextAnchor >> anchoredMorph [ 
	^ super anchoredMorph 
]

{ #category : #accessing }
MicScalingTextAnchor >> freezeHeight [

	^ freezeHeight
]

{ #category : #accessing }
MicScalingTextAnchor >> freezeHeight: anObject [

	freezeHeight := anObject
]

{ #category : #initialization }
MicScalingTextAnchor >> initialize [ 
	freezeHeight := false
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

	| newWidth newHeight |
	newWidth := rightMargin / 100 * scale.
	newHeight := freezeHeight
		         ifNil: [ original height / original width * newWidth ].
	anchoredMorph := anchoredMorph isMorph
		                 ifTrue: [ original extent: newWidth @ newHeight ]
		                 ifFalse: [ 
		                 original scaledToSize: newWidth @ newHeight ]
]
