"
I represent a reference in a text. For example `[http://pharo.org](http://pharo.org)` creates [http://pharo.org](http://pharo.org).
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

{ #category : 'printing' }
MicLinkBlock >> plainText [
	^ '[', ((self children collect: [:each | each plainText]) joinUsing: ' '), '](', url ,')'
]

{ #category : 'accessing' }
MicLinkBlock >> referencePath [

	^ self reference fullName
]
