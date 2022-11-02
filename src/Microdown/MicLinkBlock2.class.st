"
I represent a reference in a text. For example `[http://pharo.org](http://pharo.org)` creates [http://pharo.org](http://pharo.org).
"
Class {
	#name : #MicLinkBlock2,
	#superclass : #MicInlineBlockWithUrl2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicLinkBlock2 >> accept: aVisitor [
	^ aVisitor visitLink: self
]
