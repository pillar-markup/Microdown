Class {
	#name : 'MicHeaderCapitalizer',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'private' }
MicHeaderCapitalizer >> sanitize: aText [

	| anExceptionList aWordList result |
	anExceptionList := MicHeaderCapitalizationRule new
		                   defaultTextThatShouldNotBeCapitalized.
	aWordList := aText findTokens: ' '.

	result := aWordList collect: [ :w |
			          | lower |
			          lower := w asLowercase.
			          (anExceptionList includes: lower)
				          ifTrue: [ lower ]
				          ifFalse: [ w capitalized ] ].

	^ self constructString: result
]
