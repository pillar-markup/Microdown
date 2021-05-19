"
I represent a reference in a text. For example `[http://pharo.org](http://pharo.org)` creates [http://pharo.org](http://pharo.org).
"
Class {
	#name : #MicLinkBlock,
	#superclass : #MicInlineBlockWithUrl,
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicLinkBlock >> accept: aVisitor [
	^ aVisitor visitLink: self
]

{ #category : #accessing }
MicLinkBlock >> openingDelimiter [

 	^ MicLinkNameOpenerDelimiter markup
]
