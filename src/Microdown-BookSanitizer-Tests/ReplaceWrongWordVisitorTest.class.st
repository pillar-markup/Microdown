Class {
	#name : 'ReplaceWrongWordVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
ReplaceWrongWordVisitorTest >> testVisitHeader [

	| aHeader aTextBlock aReplaceWrongWordVisitor |
	aReplaceWrongWordVisitor := ReplaceWrongWordVisitor new.

	aHeader := MicHeaderBlock new.

	aTextBlock := MicTextBlock new.
	aTextBlock bodyString:
		'Le sub presenter est dans la Pharo Image avec un back-end.'.
	aHeader children add: aTextBlock.

	aReplaceWrongWordVisitor visitHeader: aHeader.

	self
		assert: aHeader children first bodyString
		equals: 'Le subpresenter est dans la Pharo image avec un backend.'
]

{ #category : 'tests' }
ReplaceWrongWordVisitorTest >> testVisitParagraph [

	| aParagraph aTextBlock aReplaceWrongWordVisitor |
	aReplaceWrongWordVisitor := ReplaceWrongWordVisitor new.

	aParagraph := MicParagraphBlock new.

	aTextBlock := MicTextBlock new.
	aTextBlock bodyString:
		'Le sub presenter est dans la Pharo Image avec un back-end.'.
	aParagraph children add: aTextBlock.

	aReplaceWrongWordVisitor visitParagraph: aParagraph.

	self
		assert: aParagraph children first bodyString
		equals: 'Le subpresenter est dans la Pharo image avec un backend.'
]
