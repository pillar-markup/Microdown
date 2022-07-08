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

{ #category : #visiting }
MicLinkBlock >> closeMe [
	<protected>
	
	| split args |
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	args := (split second ifNil: [ '' ]) trimBoth: [:char | {$". Character space} includes: char].
	self arguments: (MicArgumentList withString: args).
	self captionElements: (self inlineParse: substring).
"	self children: captionElements"
]

{ #category : #testing }
MicLinkBlock >> hasArguments [
	"Answer <true> if the receiver contain at least 1 argument"
	
	^ (self url trimBoth findTokens: ' ') size > 1
]

{ #category : #accessing }
MicLinkBlock >> kind [

 	^ #linkName
]

{ #category : #accessing }
MicLinkBlock >> openingDelimiter [

 	^ LinkNameOpenerMarkup
]

{ #category : #accessing }
MicLinkBlock >> referencePath [
	"Answer a <String> with the URL the receiver is pointing at"
	
	^ self referenceUri asString
]

{ #category : #accessing }
MicLinkBlock >> referenceUri [
	"Answer a <ZnUrl> with the target URL of the receiver"
	
	^ self reference uri
]
