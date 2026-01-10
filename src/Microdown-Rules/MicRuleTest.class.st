Class {
	#name : 'MicRuleTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}

{ #category : 'tests' }
MicRuleTest >> testMicHeaderFirstLetterCapitalizeRuleIsFalseWithAWordWithTheFirstLetterCapitalize [

	| word res |
	word := 'pharo'.
	res := MicFirstLetterCapitalizeRule new matchingPattern: word.
	self deny: res
]

{ #category : 'tests' }
MicRuleTest >> testMicHeaderFirstLetterCapitalizeRuleIsTrueWithAWordWithTheFirstLetterCapitalize [

	|word res|
	
	word := 'Pharo'.
	
	res := MicFirstLetterCapitalizeRule new matchingPattern: word.
	
	self assert: res equals: true
]

{ #category : 'tests' }
MicRuleTest >> testMicHeaderFirstLetterCapitalizeRuleWithAnEmptyString [

	| word res |
	word := ''.

	res := MicFirstLetterCapitalizeRule new matchingPattern: word.

	self assert: res equals: false
]

{ #category : 'tests' }
MicRuleTest >> testMicParagraphMissingLabelPeriodRuleIsOk [

	| aText applyRule res |
	aText := '2 Analyse'.
	applyRule := MicParagraphMissingLabelPeriodRule new.
	res := applyRule detectIncorrectLabel: aText.
	self assert: res equals: true
]

{ #category : 'tests' }
MicRuleTest >> testMicPointAtEndOfSentenceRuleIsFalseWhenSentenceDontHaveAPointAtTheEnd [

	|rule res text|
	
	text := 'I work on a pharo project'.
	
	rule := MicPointAtEndOfSentenceRule new.
	
	res := rule sentenceEndByAPoint: text.
	
	self assert: res equals: false.
]

{ #category : 'tests' }
MicRuleTest >> testMicPointAtEndOfSentenceRuleIsTrueWhenSentenceHaveAPointAtTheEnd [

	| rule res text |
	text := 'I work on a pharo project.'.

	rule := MicPointAtEndOfSentenceRule new.

	res := rule sentenceEndByAPoint: text.

	self assert: res equals: true
]
