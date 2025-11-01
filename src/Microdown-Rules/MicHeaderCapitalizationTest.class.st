Class {
	#name : 'MicHeaderCapitalizationTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderFullIsCorrectlyCapitalized [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreNotCapitalized.
	
	text := Microdown parse: '
# About capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 0.
	
]

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderFullIsNotCorrectlyCapitalized [

	| r text checker anError |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreNotCapitalized.
	
	text := Microdown parse: '
# About capitalisation of Headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 1.
	anError := checker errors first.	
	self 
		assert: anError micElement text
		equals: 'About capitalisation of Headers'.
	
	self 
		assert: anError concern 
		equals: 'Headers'
		
	
]

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderStartCorrectlyStartWithUppercase [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreNotCapitalized.
	
	text := Microdown parse: '
# About capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 0.
	
]

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderStartWronglyStartWithLowercase [

	| r text checker error |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreNotCapitalized.
	
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
		equals: 'about capitalisation of headers'.
	self 
		assert: error concern  
		equals: 'about'
]
