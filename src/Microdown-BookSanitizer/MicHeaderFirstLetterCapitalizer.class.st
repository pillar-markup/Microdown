Class {
	#name : 'MicHeaderFirstLetterCapitalizer',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'private' }
MicHeaderFirstLetterCapitalizer >> sanitize: aText [

	| words rule aLocalText stream |
	aLocalText := aText asLowercase.
	rule := MicFirstLetterCapitalizeRule new.

	words := aLocalText findTokens: ' '.


	(rule matchingPattern: (words first)) ifFalse: [
		words first ifNotEmpty: [ words at: 1 put: words first capitalized ] ].

	^ self constructString: words
]
