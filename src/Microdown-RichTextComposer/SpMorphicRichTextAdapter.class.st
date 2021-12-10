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
