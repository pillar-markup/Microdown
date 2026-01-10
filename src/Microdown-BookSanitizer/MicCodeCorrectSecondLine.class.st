Class {
	#name : 'MicCodeCorrectSecondLine',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'private' }
MicCodeCorrectSecondLine >> sanitize: aText [

	| restOfString firstLine rule |
	firstLine := aText copyUpTo: Character cr.
	restOfString := aText copyAfter: Character cr.
	rule := MicCodeSecondLineRule new.

	(rule
		 shouldInsertEmptyLineAfterFirstLine: firstLine
		 rest: restOfString) ifFalse: [ ^ aText ].

	^ firstLine , Character cr asString , Character cr asString
	  , restOfString
]
