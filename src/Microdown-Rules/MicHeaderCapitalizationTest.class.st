Class {
	#name : 'MicHeaderCapitalizationTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderWronglyStartWithLowercase [

	| r text checker error |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreNotCapitilized.
	
	text := Microdown parse: '
# about capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 1.
	error := checker errors first.
	self 
		assert: error micElement text 
		equals: 'about capitalisation of headers'
]
