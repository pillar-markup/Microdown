"
I am a brush in the canvas-brush pattern.

I represent one kind of `TextAttribute` to be added to a `Text`.
"
Class {
	#name : #BCRichTextBrush,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'attribute'
	],
	#category : #BeautifulComments
}

{ #category : #'instance creation' }
BCRichTextBrush class >> on: canvas [ 
	^self new
		canvas: canvas
]

{ #category : #'instance creation' }
BCRichTextBrush class >> on: canvas attribute: attr [
	^self new
		canvas: canvas;
		attribute: attr
]

{ #category : #accessing }
BCRichTextBrush >> attribute [
	^ attribute
]

{ #category : #accessing }
BCRichTextBrush >> attribute: anObject [
	attribute := anObject
]

{ #category : #accessing }
BCRichTextBrush >> canvas [
	^ canvas
]

{ #category : #accessing }
BCRichTextBrush >> canvas: anObject [
	canvas := anObject
]

{ #category : #paint }
BCRichTextBrush >> paint: aText [
	aText addAttribute: attribute 
]
