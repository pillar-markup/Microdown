"
I am a Canvas in the Canvas-Brush pattern. I keep an output stream of type `Text`.
As texts can have multiple annotations, I have a stack of brushes to paint a text with. 
My only method for adding text to my stream is `<<`.
"
Class {
	#name : 'MicRichTextCanvas',
	#superclass : 'Object',
	#instVars : [
		'out',
		'brushes',
		'nesting',
		'crAtEnd',
		'textStyler'
	],
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'public' }
MicRichTextCanvas >> << aText [
	|text|
	aText ifEmpty: [ ^ self ].
	text := aText asText.
	brushes do: [ :brush | brush paint: text ].
	"If no font is already put, and a body font is defined, apply it"
	((self hasFontDefinitions: text) not and: [ self textStyler bodyFont notNil])
		ifTrue: [
			text addAttribute: (TextFontReference toFont: self textStyler bodyFont)].
	out << text.
	text ifNotEmpty: [crAtEnd := text last = Character cr].
]

{ #category : 'public' }
MicRichTextCanvas >> contents [
	^ out contents
]

{ #category : 'public' }
MicRichTextCanvas >> cr [
	self newLine
]

{ #category : 'testing' }
MicRichTextCanvas >> hasFontDefinitions: aText [
	"Answer the fontfor characters in the run beginning at characterIndex."
	^ (aText runs flattened asSet select: [ :attr | attr isKindOf: TextFontReference  ]) isNotEmpty.
]

{ #category : 'public' }
MicRichTextCanvas >> includeAttribute: attr in: aBlock [
	brushes addLast: (MicRichTextBrush on: self attribute: attr).
	aBlock value.
	brushes removeLast
]

{ #category : 'public' }
MicRichTextCanvas >> includeBrush: aBrush in: aBlock [
	"Add for the course of aBlock, a brush (aBrush) to the currently used brushes."
	brushes addLast: aBrush.
	aBlock value.
	brushes removeLast
]

{ #category : 'public' }
MicRichTextCanvas >> indentIn: aBlock [ 
	nesting := nesting + 1.
	aBlock value.
	nesting := nesting - 1.
	
		
]

{ #category : 'initialization' }
MicRichTextCanvas >> initialize [
	super initialize.
	out := WriteStream on: '' asText.
	brushes := OrderedCollection with: (MicRichTextIndentBrush on: self).
	nesting := 0.
	crAtEnd := true. "Prevent newlines in beginning"
]

{ #category : 'accessing' }
MicRichTextCanvas >> nesting [
	^ nesting
]

{ #category : 'public' }
MicRichTextCanvas >> newLine [
	self newLineBody.
	crAtEnd := true
]

{ #category : 'private' }
MicRichTextCanvas >> newLineBody [
	self << self textStyler newLineBody 
]

{ #category : 'public' }
MicRichTextCanvas >> newLineIfNotAlready [
	crAtEnd
		ifFalse: [ self << self textStyler newLineIfNotAlready  ].
	crAtEnd := true
]

{ #category : 'private' }
MicRichTextCanvas >> tab [
	self << String tab asText
]

{ #category : 'accessing' }
MicRichTextCanvas >> textStyler [

	^ textStyler
]

{ #category : 'accessing' }
MicRichTextCanvas >> textStyler: anObject [

	textStyler := anObject
]
