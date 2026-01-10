Class {
	#name : 'MicCodeEndWithoutPeriod',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'private' }
MicCodeEndWithoutPeriod >> sanitize: methodBody [

	| lines lastLineIndex lastLine |
	lastLineIndex := MicCodeEndWithPeriodRule new findLastLinePeriod: methodBody.
	lastLineIndex = 0 ifTrue: [ ^ methodBody ].

	lines := methodBody lines asOrderedCollection.
	lastLine := lines at: lastLineIndex.

	lines at: lastLineIndex put: lastLine allButLast.

	^ String cr join: lines
]
