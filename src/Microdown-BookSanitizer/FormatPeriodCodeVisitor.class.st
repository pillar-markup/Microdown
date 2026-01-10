Class {
	#name : 'FormatPeriodCodeVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'visiting' }
FormatPeriodCodeVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeEndWithoutPeriod new sanitize: aMicCodeBlock code)
]
