Class {
	#name : 'FormatSecondLineCodeVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
FormatSecondLineCodeVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeCorrectSecondLine new sanitize: aMicCodeBlock code)
]
