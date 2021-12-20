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
		getSelectionSelector: #readSelection;
		setSelectionSelector: #setSelection:;
		getTextSelector: #getText;
		setTextSelector: #accept:notifying:;
		yourself.
	
	newWidget setText: self presenter text.
	self presenter selectionInterval 
		ifNotNil: [  :anInterval | self selectionInterval: anInterval].
	^ newWidget
]

{ #category : #'morph->presenter' }
SpMorphicRichTextAdapter >> getText [
	"called by morph to get text from model"
	^ model text
]

{ #category : #'morph->presenter' }
SpMorphicRichTextAdapter >> menu [
	^ nil.
]

{ #category : #'presenter->morph' }
SpMorphicRichTextAdapter >> selectionInterval [
	"called by the presenter to get the selection in the morph"
	^ self widget selectionInterval
]

{ #category : #'presenter->morph' }
SpMorphicRichTextAdapter >> selectionInterval: anInterval [
	"called by presenter to set selection in morph"
	self widgetDo: [ :w | w setTextAreaSelection: anInterval ].
	
]

{ #category : #'morph->presenter' }
SpMorphicRichTextAdapter >> setSelection: interval [
	"Called when a selection happens in the widget"
	self model selectionInterval: interval
]

{ #category : #'presenter->morph' }
SpMorphicRichTextAdapter >> setText: aText [
	"called by presenter to set text in morph"
	widget ifNotNil: [ widget setText: aText ]
]

{ #category : #'morph->presenter' }
SpMorphicRichTextAdapter >> shiftMenu [
	^ nil.
]
