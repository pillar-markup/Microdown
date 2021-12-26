"
I am part of the three classes which implement the RichTextPresenter. 

## Implementation
I override `font:` to do nothing, preventing the Spec engine to remove the fonts in the text.

I override `textAreaExtentChanged` to hook into rescaling of UI. Notice I assume my model is a `SpMorphicRichTextAdapter`, and that its model is a `SpRichTextPresenter`. 
"
Class {
	#name : #MicScrolledTextMorph,
	#superclass : #RubScrolledTextMorph,
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #accessing }
MicScrolledTextMorph >> font: aFont [
	"we do not want to set the font, so we do nothing here"
]

{ #category : #'event handling' }
MicScrolledTextMorph >> textAreaExtentChanged [
	super textAreaExtentChanged.
	"When textArea size change, scalable images might need to be redrawn"
	self model model renderWidth: self width.
	self resetState

]
