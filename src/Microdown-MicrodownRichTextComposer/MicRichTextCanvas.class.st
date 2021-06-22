"
I am a Canvas in the Canvas-Brush pattern. I keep an output stream of type `Text`.
As texts can have multiple annotations, I have a stack of brushes to paint a text with. 
My only method for adding text to my stream is `<<`.
"
Class {
	#name : #MicRichTextCanvas,
	#superclass : #Object,
	#instVars : [
		'out',
		'brushes',
		'nesting',
		'crAtEnd'
	],
	#category : #'Microdown-MicrodownRichTextComposer'
}

{ #category : #public }
MicRichTextCanvas >> << aText [
	brushes do: [ :brush | brush paint: aText ].
	out << aText.
	aText ifNotEmpty: [crAtEnd := aText last = Character cr].
]

{ #category : #public }
MicRichTextCanvas >> contents [
	^ out contents
]

{ #category : #public }
MicRichTextCanvas >> cr [
	self newLine
]

{ #category : #public }
MicRichTextCanvas >> includeAttribute: attr in: aBlock [
	brushes addLast: (MicRichTextBrush on: self attribute: attr).
	aBlock value.
	brushes removeLast
]

{ #category : #public }
MicRichTextCanvas >> includeBrush: aBrush in: aBlock [
	"Add for the course of aBlock, a brush (aBrush) to the currently used brushes."
	brushes addLast: aBrush.
	aBlock value.
	brushes removeLast
]

{ #category : #public }
MicRichTextCanvas >> indentIn: aBlock [ 
	nesting := nesting + 1.
	aBlock value.
	nesting := nesting - 1.
	
		
]

{ #category : #initialization }
MicRichTextCanvas >> initialize [
	super initialize.
	out := WriteStream on: '' asText.
	brushes := OrderedCollection with: (MicRichTextIndentBrush on: self).
	nesting := 0.
	crAtEnd := true. "Prevent newlines in beginning"
]

{ #category : #accessing }
MicRichTextCanvas >> nesting [
	^ nesting
]

{ #category : #public }
MicRichTextCanvas >> newLine [
	self newLineBody.
	crAtEnd := true
]

{ #category : #private }
MicRichTextCanvas >> newLineBody [
	self << String cr asText
]

{ #category : #public }
MicRichTextCanvas >> newLineIfNotAlready [
	crAtEnd
		ifFalse: [ self newLineBody ].
	crAtEnd := true
]

{ #category : #private }
MicRichTextCanvas >> tab [
	self << String tab asText
]
