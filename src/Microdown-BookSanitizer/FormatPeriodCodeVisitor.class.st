Class {
	#name : 'FormatPeriodCodeVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
FormatPeriodCodeVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeEndWithoutPeriod new sanitize: aMicCodeBlock code)
]
