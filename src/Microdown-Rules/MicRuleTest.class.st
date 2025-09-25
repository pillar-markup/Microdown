Class {
	#name : 'MicRuleTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
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
MicRuleTest >> testSimpleRule [

	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: { 'sub-presenter' -> 'subpresenter' .
			'sub presenter' -> 'subpresenter' .
			'meta object' -> 'metaobject'}.
	self assert: r pairs size equals: 3
]
