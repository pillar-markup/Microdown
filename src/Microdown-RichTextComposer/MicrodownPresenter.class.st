"
I am intended to be a specialized RichTextPresenter which works with a microdown document rather than the composed text.
"
Class {
	#name : #MicrodownPresenter,
	#superclass : #SpRichTextPresenter,
	#instVars : [
		'document',
		'textStyler'
	],
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #'instance creation' }
MicrodownPresenter class >> open [
	<script>
	(self new 
		document: SpRichTextPresenter cheetSheet  ) openWithSpec 
]

{ #category : #accessing }
MicrodownPresenter >> document [

	^ document
]

{ #category : #accessing }
MicrodownPresenter >> document: aNode [

	document := aNode.
	self text: (MicRichTextComposer  new 
		textStyler: self textStyler; 
		asRichText: aNode)
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
MicrodownPresenter >> textStyler: anObject [

	textStyler := anObject
]
