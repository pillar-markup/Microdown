Class {
	#name : 'ReplaceWrongWordVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
ReplaceWrongWordVisitor >> visitHeader: aHeader [

	| aText aMicReplaceWrongWord atext2 |
	aText := aHeader children first bodyString.

	aMicReplaceWrongWord := MicReplaceWrongWord new.
	atext2 := aMicReplaceWrongWord sanitize: aText.
	aHeader children first bodyString: atext2
]

{ #category : 'visiting' }
ReplaceWrongWordVisitor >> visitParagraph: aParagraph [

	| aText aMicReplaceWrongWord atext2 |
	aText := aParagraph children first bodyString.

	aMicReplaceWrongWord := MicReplaceWrongWord new.
	atext2 := aMicReplaceWrongWord sanitize: aText.
	aParagraph children first bodyString: atext2
]
