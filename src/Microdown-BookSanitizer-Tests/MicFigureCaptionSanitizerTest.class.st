Class {
	#name : 'MicFigureCaptionSanitizerTest',
	#superclass : 'MicAbstractSanitizerTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
MicFigureCaptionSanitizerTest >> testSanitizeIsGreatForAllRules [

	| aText res |
	aText := 'i love pharo'.

	res := MicFigureCaptionSanitizer new sanitize: aText.

	self assert: res equals: 'I love pharo.'
]
