Class {
	#name : 'MicRuleCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerFindOneMistake [

	| ck doc |
	ck := MicRuleChecker new. 
	ck addRule: MicMisusedVocabularyRule sample.
	ck prepareForChecking.
	
	
	doc := Microdown parse: 'this is text with a mistake: sub presenter should not be used.'.
	ck visit: doc.
	self assert: ck errors size equals: 1

]

{ #category : 'tests' }
MicRuleCheckerTest >> testCheckerPrepare [

	| ck |
	ck := MicRuleChecker new. 
	ck addRule: MicMisusedVocabularyRule sample.
	ck prepareForChecking.
	self assert: ck patterns equals: #('*sub-presenter*' '*sub presenter*' '*meta object*')
]
