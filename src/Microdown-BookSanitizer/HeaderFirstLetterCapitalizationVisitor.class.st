Class {
	#name : 'HeaderFirstLetterCapitalizationVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'visiting' }
HeaderFirstLetterCapitalizationVisitor >> visitHeader: aHeader [

	| aText aMicHeaderFirstLetterCapitalizator atext2 |
	aText := aHeader text.
	aMicHeaderFirstLetterCapitalizator := MicHeaderFirstLetterCapitalizer new.
	atext2 := aMicHeaderFirstLetterCapitalizator sanitize: aText.
	aHeader children first bodyString: atext2
]
