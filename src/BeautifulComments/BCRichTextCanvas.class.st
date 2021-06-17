"
I am a Canvas in the Canvas-Brush pattern. I keep an output stream of type `Text`.
As texts can have multiple annotations, I have a stack of brushes to paint a text with. 
My only method for adding text to my stream is `<<`.
"
Class {
	#name : #BCRichTextCanvas,
	#superclass : #Object,
	#instVars : [
		'out',
		'brushes',
		'nesting',
		'crAtEnd'
	],
	#category : #BeautifulComments
}

{ #category : #public }
BCRichTextCanvas >> << aText [
	brushes do: [ :brush | brush paint: aText ].
	out << aText.
	aText ifNotEmpty: [crAtEnd := aText last = Character cr].
]

{ #category : #public }
BCRichTextCanvas >> contents [
	^ out contents
]

{ #category : #public }
BCRichTextCanvas >> cr [
	self newLine
]

{ #category : #public }
BCRichTextCanvas >> includeAttribute: attr in: aBlock [
	brushes addLast: (BCRichTextBrush on: self attribute: attr).
	aBlock value.
	brushes removeLast
]

{ #category : #public }
BCRichTextCanvas >> includeBrush: aBrush in: aBlock [
	"Add for the course of aBlock, a brush (aBrush) to the currently used brushes."
	brushes addLast: aBrush.
	aBlock value.
	brushes removeLast
]

{ #category : #public }
BCRichTextCanvas >> indentIn: aBlock [ 
	nesting := nesting + 1.
	aBlock value.
	nesting := nesting - 1.
	
		
]

{ #category : #initialization }
BCRichTextCanvas >> initialize [
	super initialize.
	out := WriteStream on: '' asText.
	brushes := OrderedCollection with: (BCRichTextIndentBrush on: self).
	nesting := 0.
	crAtEnd := true. "Prevent newlines in beginning"
]

{ #category : #accessing }
BCRichTextCanvas >> nesting [
	^ nesting
]

{ #category : #public }
BCRichTextCanvas >> newLine [
	self newLineBody.
	crAtEnd := true
]

{ #category : #private }
BCRichTextCanvas >> newLineBody [
	self << String cr asText
]

{ #category : #public }
BCRichTextCanvas >> newLineIfNotAlready [
	crAtEnd
		ifFalse: [ self newLineBody ].
	crAtEnd := true
]

{ #category : #private }
BCRichTextCanvas >> tab [
	self << String tab asText
]
