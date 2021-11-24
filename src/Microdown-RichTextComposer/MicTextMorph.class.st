"
I override `textAreaExtentChanged` to hook into rescaling of UI.
"
Class {
	#name : #MicTextMorph,
	#superclass : #RubScrolledTextMorph,
	#instVars : [
		'textAreaChanged'
	],
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #accessing }
MicTextMorph >> textAreaChanged [

	^ textAreaChanged
]

{ #category : #accessing }
MicTextMorph >> textAreaChanged: anObject [

	textAreaChanged := anObject
]

{ #category : #'event handling' }
MicTextMorph >> textAreaExtentChanged [
	self manageLayout.
	self textAreaChanged ifNotNil: [ self textAreaChanged value ]

]
