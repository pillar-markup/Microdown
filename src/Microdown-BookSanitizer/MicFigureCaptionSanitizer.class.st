Class {
	#name : 'MicFigureCaptionSanitizer',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'private' }
MicFigureCaptionSanitizer >> sanitize: aText [

	| localText firstLetterRule pointRule words firstWord lastWord |
	localText := aText.

	firstLetterRule := MicFirstLetterCapitalizeRule new.
	pointRule := MicPointAtEndOfSentenceRule new.

	words := localText findTokens: ' '.
	words isEmpty ifTrue: [ ^ aText ].

	firstWord := words first.

	(firstLetterRule matchingPattern: firstWord) 
		ifFalse: [ words at: 1 put: firstWord capitalized ].

	(pointRule sentenceEndByAPoint: localText) 
		ifFalse: [
			lastWord := words last.
			words removeLast.
			lastWord := lastWord , '.'.
			words add: lastWord ].

	^ self constructString: words
]
