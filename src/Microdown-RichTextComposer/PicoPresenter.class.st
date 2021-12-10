"
I am a temporary exploration class used to track down the core reason for pharo issue Pharo #10297.
"
Class {
	#name : #PicoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'textMorph'
	],
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #specs }
PicoPresenter class >> defaultSpec [
	 ^ SpBoxLayout newTopToBottom
			add: #textMorph;
			yourself
]

{ #category : #initialization }
PicoPresenter >> initializePresenters [

	super initializePresenters.
	textMorph  := self newMorph
	



]

{ #category : #accessing }
PicoPresenter >> text [
	^Microdown asRichText:  MicrodownPresenter sampleDocument
]

{ #category : #initialization }
PicoPresenter >> updatePresenter [
	textMorph morph: (RubEditingArea   new
			updateTextWith: self text;
			beWrapped;
			hResizing: #spaceFill; 
			vResizing: #spaceFill;
			in: [ :this | this textArea readOnly: true ];
			yourself)
]
