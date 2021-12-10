Class {
	#name : #SpMorphicRichTextAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #factory }
SpMorphicRichTextAdapter >> buildWidget [
	| newWidget |
	
	newWidget := (SpRichTextMorph  on: self)
		getSelectionSelector: #readSelection;
		menuProvider: self selector: #codePaneMenu:shifted:;
		setSelectionSelector: #setSelection:;
		beWrapped;
		enabled: self enabled;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		registerScrollChanges: #scrollValueChanged:;
		hScrollbarShowWhenNeeded;
		yourself.	
	^ newWidget
]

{ #category : #accessing }
SpMorphicRichTextAdapter >> getText [
	^ model text
]
