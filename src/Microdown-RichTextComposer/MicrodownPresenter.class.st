Class {
	#name : #MicrodownPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'document',
		'textMorph'
	],
	#category : #'Microdown-RichTextComposer'
}

{ #category : #specs }
MicrodownPresenter class >> defaultSpec [
	 ^ SpBoxLayout newTopToBottom
			add: #textMorph;
			yourself
]

{ #category : #'instance creation' }
MicrodownPresenter class >> open [
	<script>
	(self on: self sampleDocument) openWithSpec 
]

{ #category : #'instance creation' }
MicrodownPresenter class >> sampleDocument [
	"I return a sample document"
	^ Microdown parse: '### Links
This is just first line with an inline web ref [Pharo](http://pharo.org/)

[![](https://pharo.org/web/files/pharo.png)](http://pharo.org/)

Here are direct links to classes and method
- `String`
- `String>>#trim`

And this is another line'
]

{ #category : #accessing }
MicrodownPresenter >> document [

	^ document
]

{ #category : #accessing }
MicrodownPresenter >> document: aNode [

	document := aNode.
	text := Microdown asRichText: document
]

{ #category : #initialization }
MicrodownPresenter >> initializePresenters [

	super initializePresenters.
	textMorph  := self newMorph
		morph: (RubScrolledTextMorph new
			beWrapped;
			hResizing: #spaceFill; 
			vResizing: #spaceFill;
			in: [ :this | this textArea readOnly: true ];
			setText: self text;
			yourself);
		yourself.




]

{ #category : #initialization }
MicrodownPresenter >> parserClass [ 
	^ MicroDownParser
]

{ #category : #initialization }
MicrodownPresenter >> render [
	text := Microdown asRichText: document
]

{ #category : #accessing }
MicrodownPresenter >> setModelBeforeInitialization: aNode [

	self document: aNode
]

{ #category : #accessing }
MicrodownPresenter >> text [

	^ text
]
