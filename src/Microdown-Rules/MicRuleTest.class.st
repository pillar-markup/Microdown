Class {
	#name : 'MicRuleTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules-Old',
	#package : 'Microdown-Rules',
	#tag : 'Old'
}

{ #category : 'tests' }
MicRuleTest >> testGoodWordFor [

	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: { 'sub-presenter' -> 'subpresenter' .
			'sub presenter' -> 'subpresenter' .
			'meta object' -> 'metaobject'}.
	self 
		assert: (r goodWordFor: 'meta object') 
		equals: 'metaobject'.
	self 
		assert: (r goodWordFor: 'sub presenter') 
		equals: 'subpresenter'.
]

{ #category : 'tests' }
MicRuleTest >> testMatchingSource [

	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: { 'sub-presenter' -> 'subpresenter' .
			'sub presenter' -> 'subpresenter' .
			'meta object' -> 'metaobject'}.
	self 
		assert: r matchingPatterns 
		equals: #('*sub-presenter*' '*sub presenter*' '*meta object*') 
]

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

{ #category : 'tests' }
MicRuleTest >> testSimpleRule [

	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: { 'sub-presenter' -> 'subpresenter' .
			'sub presenter' -> 'subpresenter' .
			'meta object' -> 'metaobject'}.
	self assert: r pairs size equals: 3
]
