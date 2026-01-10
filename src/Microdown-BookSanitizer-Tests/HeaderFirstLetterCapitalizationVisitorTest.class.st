Class {
	#name : 'HeaderFirstLetterCapitalizationVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
HeaderFirstLetterCapitalizationVisitorTest >> testVisitHeader [

	| aHeader aParagraph aTextBlock firstLetterCapitalizationVisitor |
	firstLetterCapitalizationVisitor := HeaderFirstLetterCapitalizationVisitor
		                                    new.

	aHeader := MicHeaderBlock new.

	aParagraph := MicParagraphBlock new.

	aTextBlock := MicTextBlock new.
	aTextBlock bodyString: 'i made A C3P project'.
	aHeader children add: aTextBlock.

	firstLetterCapitalizationVisitor visitHeader: aHeader.

	self
		assert: aHeader children first bodyString
		equals: 'I made a c3p project'
]
