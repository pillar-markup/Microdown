"
I am a presenter for a microdown document.

The document rendered into a Text in the document: method.

It is possible to control various aspects of the Text generation using a `MicTextStyler` instance.
"
Class {
	#name : #MicrodownPresenter,
	#superclass : #MicTextPresenter,
	#instVars : [
		'#document => ObservableSlot',
		'#textStyler => ObservableSlot'
	],
	#category : #'Microdown-RichTextPresenter'
}

{ #category : #'instance creation' }
MicrodownPresenter class >> open [
	<script>
	(self new 
		document: MicTextPresenter cheetSheet  ) openWithSpec 
]

{ #category : #composing }
MicrodownPresenter >> compose [

	self document ifNil: [ ^self ].
	self text: (MicRichTextComposer  new 
		textStyler: self textStyler; 
		asRichText: self document)
]

{ #category : #accessing }
MicrodownPresenter >> document [

	^ document
]

{ #category : #accessing }
MicrodownPresenter >> document: aNode [

	document := aNode.
	self compose.
]

{ #category : #accessing }
MicrodownPresenter >> documentFromString: aString [

	self document: (self parserClass parse: aString)
	
		
]

{ #category : #initialization }
MicrodownPresenter >> parserClass [ 
	^ MicroDownParser
]

{ #category : #accessing }
MicrodownPresenter >> textStyler [
	textStyler ifNil: [ textStyler := MicTextStyler new ].
	^ textStyler
]

{ #category : #accessing }
MicrodownPresenter >> textStyler: styler [

	textStyler := styler.
	self compose
]

{ #category : #enumerating }
MicrodownPresenter >> whenDocumentChangedDo: aBlock [

	self property: #document whenChangedDo: aBlock
]

{ #category : #enumerating }
MicrodownPresenter >> whenTextStylerChangedDo: aBlock [

	self property: #textStyler whenChangedDo: aBlock
]
