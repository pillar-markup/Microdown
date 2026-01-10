Class {
	#name : 'AddParagraphLabelPeriodVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
AddParagraphLabelPeriodVisitor >> visitParagraph: aParagraph [

	| aText aMicAddParagraphLabelPeriod atext2 |
	aText := aParagraph children first bodyString.

	aMicAddParagraphLabelPeriod := MicAddParagraphLabelPeriod new.
	atext2 := aMicAddParagraphLabelPeriod sanitize: aText.
	aParagraph children first bodyString: atext2
]
