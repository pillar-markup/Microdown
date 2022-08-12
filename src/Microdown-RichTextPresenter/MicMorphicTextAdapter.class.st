"
I am an adapter used by `SpRichTextPresenter` to connect to a `SpRichTextMorph`.

## Implementation
My primary method is `buildWidget` which creates an instance of `SpRichTextMorph`. 
My model (inherited instance variable) is a `SpRichTextPresenter`. 

Perhaps in the future the methods for menu and shiftMenu should be forwarded to the presenter.
"
Class {
	#name : #MicMorphicTextAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Microdown-RichTextPresenter'
}

{ #category : #factory }
MicMorphicTextAdapter >> buildWidget [
	| newWidget |
	
	newWidget := (MicScrolledTextMorph  on: self)
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
MicMorphicTextAdapter >> getText [
	"called by morph to get text from model"
	^ model text
]

{ #category : #'morph->presenter' }
MicMorphicTextAdapter >> menu [
	^ nil.
]

{ #category : #'presenter->morph' }
MicMorphicTextAdapter >> selectionInterval [
	"called by the presenter to get the selection in the morph"
	^ self widget selectionInterval
]

{ #category : #'presenter->morph' }
MicMorphicTextAdapter >> selectionInterval: anInterval [
	"called by presenter to set selection in morph"
	self widgetDo: [ :w | w setTextAreaSelection: anInterval ].
	
]

{ #category : #'morph->presenter' }
MicMorphicTextAdapter >> setSelection: interval [
	"Called when a selection happens in the widget"
	self model selectionInterval: interval
]

{ #category : #'presenter->morph' }
MicMorphicTextAdapter >> setText: aText [
	"called by presenter to set text in morph"
	widget ifNotNil: [ 
		widget 
			setText: aText;
			resetState ]
]

{ #category : #'morph->presenter' }
MicMorphicTextAdapter >> shiftMenu [
	^ nil.
]
