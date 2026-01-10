Class {
	#name : 'MicHeaderFirstLetterCapitalizerTest',
	#superclass : 'MicAbstractSanitizerTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
MicHeaderFirstLetterCapitalizerTest >> testSanitizeIsGreat [

	|rule text res|
	
	text := 'i work in a pharo Project'.
	
	rule := MicHeaderFirstLetterCapitalizer new.
	
	res := rule sanitize: text.
	
	self assert: res equals: 'I work in a pharo project'
]
