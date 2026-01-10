Class {
	#name : 'CodeFormatVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
CodeFormatVisitorTest >> testCodeBlockFormatFirstLine [

	| aMicCodeBock aCodeFormatVisitor |
	aMicCodeBock := MicCodeBlock new.

	aMicCodeBock body: 'MyPlayer >> play
	| pieces |
	pieces := self king isInCheck
		          ifTrue: [ OrderedCollection with: self king ]
		          ifFalse: [ self pieces copy asOrderedCollection ].


	[ pieces notEmpty ] whileTrue: [
		| piece legalMoves |
		piece := pieces atRandom.
		pieces remove: piece.
		legalMoves := piece legalTargetSquares.
		legalMoves ifNotEmpty: [
			game move: piece to: legalMoves atRandom.
			^ self ] ].'.

	aCodeFormatVisitor := BookSanitizerVisitor new.
	aCodeFormatVisitor addVisitor: FormatCodeTabsVisitor new.
	aCodeFormatVisitor addVisitor: FormatSecondLineCodeVisitor new.


	aCodeFormatVisitor visitCode: aMicCodeBock.

	self assert: aMicCodeBock body equals: 'MyPlayer >> play

	| pieces |
	pieces := self king isInCheck
		          ifTrue: [ OrderedCollection with: self king ]
		          ifFalse: [ self pieces copy asOrderedCollection ].


	[ pieces notEmpty ] whileTrue: [
		| piece legalMoves |
		piece := pieces atRandom.
		pieces remove: piece.
		legalMoves := piece legalTargetSquares.
		legalMoves ifNotEmpty: [
			game move: piece to: legalMoves atRandom.
			^ self ] ]'
]
