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
MicTextMorph >> font: aFont [
	"Until there is a solid solution to pharo issue: 10297 we just ignore font changes"
]

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
	super textAreaExtentChanged.
	self textAreaChanged ifNotNil: [ self textAreaChanged value ]

]
