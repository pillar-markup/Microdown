"
I represent an url reference in a text. For example, `[The pharo web site](http://pharo.org)` gives [The Pharo web site](http://pharo.org).
The `reference` method returns the `http://pharo.org` part.

For anchor references such as See Figure, Equations or code block have a look at MicAnchorReferenceBlock.
"
Class {
	#name : 'MicLinkBlock',
	#superclass : 'MicInlineBlockWithUrl',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicLinkBlock class >> closingDelimiter [

 	^ NameCloserUrlOpener
]

{ #category : 'accessing' }
MicLinkBlock class >> openingDelimiter [

 	^ LinkNameOpenerMarkup
]

{ #category : 'visiting' }
MicLinkBlock >> accept: aVisitor [
	^ aVisitor visitLink: self
]

{ #category : 'visiting' }
MicLinkBlock >> closeMe [

	super closeMe.
	self children do: [ :each | each basicParent: self ].
]

{ #category : 'printing' }
MicLinkBlock >> plainText [
	^ '[', ((self children collect: [:each | each plainText]) joinUsing: ' '), '](', url ,')'
]

{ #category : 'accessing' }
MicLinkBlock >> referencePath [

	^ self reference fullName
]

{ #category : 'printing' }
MicLinkBlock >> text [
	^ '[', ((self children collect: [:each | each text]) joinUsing: ' '), '](', url ,')'
]
