Class {
	#name : 'FormatSecondLineCodeVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'visiting' }
FormatSecondLineCodeVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeCorrectSecondLine new sanitize: aMicCodeBlock code)
]
