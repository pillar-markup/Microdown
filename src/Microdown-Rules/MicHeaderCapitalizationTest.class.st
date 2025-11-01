Class {
	#name : 'MicHeaderCapitalizationTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testCapitalizedHeaderFullIsCorrectlyCapitalized [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r addDefaultTextThatShouldNotBeCapitalized.
	r shouldVerifyHeadersAreCapitalized.
	
	"here there is a word that should not be uppercase: of so it should 
	not produce an error."
	
	text := Microdown parse: '
# About Capitalisation of Headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyUppercase. "Duplicated specification we could delegate the strategy setup to the rule"
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 0.
	
]

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testCapitalizedHeaderWithoutStopWordsIsCorrectlyCapitalized [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreCapitalized.
	
	"here there is no stopward that should not be capitalized. 
	So all the elements should be uppercase."
	text := Microdown parse: '
# About Header Capitalisation 		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyUppercase. "Duplicated specification we could delegate the strategy setup to the rule"
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 0.
	
]

{ #category : 'tests' }
MicHeaderCapitalizationTest >> testHeaderFullIsCorrectlyCapitalized [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreLowercase.
	
	text := Microdown parse: '
# About capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyLowercase. "Duplicated specification we could delegate the strategy setup to the rule"
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
	r shouldVerifyHeadersAreLowercase.
	
	text := Microdown parse: '
# About capitalisation of Headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyLowercase. "Duplicated specification we could delegate the strategy setup to the rule"
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
MicHeaderCapitalizationTest >> testHeaderFullIsNotCorrectlyCapitalizedStopWords [

	| r text checker anError |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreLowercase.
	
	text := Microdown parse: '
# About capitalisation Of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyLowercase. "Duplicated specification we could delegate the strategy setup to the rule"
	checker visit: text. 
	
	self 
		assert: checker errors size 
		equals: 1.
	anError := checker errors first.	
	self 
		assert: anError micElement text
		equals: 'About capitalisation Of headers'.
	
	self 
		assert: anError concern 
		equals: 'Of'
		
	
]

{ #category : 'tests - header start' }
MicHeaderCapitalizationTest >> testHeaderStartCorrectlyStartWithUppercase [

	| r text checker |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreLowercase.
	
	text := Microdown parse: '
# About capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyLowercase. "Duplicated specification we could delegate the strategy setup to the rule"
	checker visit: text. 
	self 
		assert: checker errors size 
		equals: 0.
	
]

{ #category : 'tests - header start' }
MicHeaderCapitalizationTest >> testHeaderStartWronglyStartWithLowercase [

	| r text checker error |
	r := MicHeaderCapitalizationRule new.
	r name: 'Header Capitalization'.
	r shouldVerifyHeadersAreLowercase.
	
	text := Microdown parse: '
# about capitalisation of headers		
	'.
	checker := MicRuleHeaderChecker new.
	checker addRule: r.
	checker verifyLowercase. "Duplicated specification we could delegate the strategy setup to the rule"
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
