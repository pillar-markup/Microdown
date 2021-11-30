"
I represent a reference in a text. For example `[http://pharo.org](http://pharo.org)` creates [http://pharo.org](http://pharo.org).
"
Class {
	#name : #MicLinkBlock,
	#superclass : #MicInlineBlockWithUrl,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicLinkBlock >> accept: aVisitor [
	^ aVisitor visitLink: self
]

{ #category : #visiting }
MicLinkBlock >> closeMe [
	
	self reference: (MicResourceReference fromUri: self url).
	captionElements := self inlineParse: substring.
]

{ #category : #accessing }
MicLinkBlock >> kind [

 	^ #linkName
]

{ #category : #accessing }
MicLinkBlock >> openingDelimiter [

 	^ MicLinkNameOpenerDelimiter markup
]

{ #category : #accessing }
MicLinkBlock >> reference [

	^ reference
]

{ #category : #accessing }
MicLinkBlock >> reference: anObject [

	reference := anObject
]
