"
I am an adapter used by `SpRichTextPresenter` to connect to a `SpRichTextMorph`.

## Implementation
My primary method is `buildWidget` which creates an instance of `SpRichTextMorph`. 
My model (inherited instance variable) is a `SpRichTextPresenter`. 

Perhaps in the future the methods for menu and shiftMenu should be forwarded to the presenter.
"
Class {
	#name : #SpMorphicRichTextAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #factory }
SpMorphicRichTextAdapter >> buildWidget [
	| newWidget |
	
	newWidget := (SpRichTextMorph  on: self)
		beReadOnly;
		beWrapped;
		enabled: self enabled;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		hScrollbarShowWhenNeeded;
		yourself.	
	^ newWidget
]

{ #category : #accessing }
SpMorphicRichTextAdapter >> getText [
	^ model text
]

{ #category : #factory }
SpMorphicRichTextAdapter >> menu [
	^ nil.
]

{ #category : #factory }
SpMorphicRichTextAdapter >> shiftMenu [
	^ nil.
]
