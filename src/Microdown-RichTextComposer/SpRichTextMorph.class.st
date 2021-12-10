"
I override `textAreaExtentChanged` to hook into rescaling of UI.
"
Class {
	#name : #SpRichTextMorph,
	#superclass : #RubScrolledTextMorph,
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #accessing }
SpRichTextMorph >> font: aFont [
	"we do not want to set the font, so we do nothing here"
]

{ #category : #'event handling' }
SpRichTextMorph >> textAreaExtentChanged [
	super textAreaExtentChanged.
	self model model render

]
