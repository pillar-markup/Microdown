"
I represent a reference in a text. For example `[http://pharo.org](http://pharo.org)` creates [http://pharo.org](http://pharo.org).
"
Class {
	#name : #MicLinkBlock2,
	#superclass : #MicInlineBlockWithUrl2,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicLinkBlock2 class >> closingDelimiter [

 	^ NameCloserUrlOpener
]

{ #category : #accessing }
MicLinkBlock2 class >> openingDelimiter [

 	^ LinkNameOpenerMarkup
]

{ #category : #visiting }
MicLinkBlock2 >> accept: aVisitor [
	^ aVisitor visitLink: self
]

{ #category : #printing }
MicLinkBlock2 >> plainText [
	^ '[', ((self children collect: #plainText) joinUsing: ' '), '](', url ,')'
]
