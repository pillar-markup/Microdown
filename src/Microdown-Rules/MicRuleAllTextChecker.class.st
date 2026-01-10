Class {
	#name : 'MicRuleAllTextChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rules',
		'errors',
		'patternPairs'
	],
	#category : 'Microdown-Rules-Old',
	#package : 'Microdown-Rules',
	#tag : 'Old'
}

{ #category : 'adding' }
MicRuleAllTextChecker >> addRule: aRule [ 
	rules add: aRule.
]

{ #category : 'as yet unclassified' }
MicRuleAllTextChecker >> checkText: aMicText [

	| foundProblems |
	"#( *xxx* -> r . *x x* -> r)"
	
	foundProblems := patternPairs select: [ :each |
		                 each key match: aMicText bodyString ].
	foundProblems do: [ :each |
			errors add: (MicUseofWrongVocabularyReport new
					 micElement: aMicText; 
					 inFile: aMicText fromFile;
					 rule: each value;
					 pattern: each key) ]
]

{ #category : 'accessing' }
MicRuleAllTextChecker >> errors [
	^ errors
]

{ #category : 'initialization' }
MicRuleAllTextChecker >> initialize [ 

	super initialize.
	rules := OrderedCollection new. 
	errors := OrderedCollection new.
]

{ #category : 'accessing' }
MicRuleAllTextChecker >> patterns [
	^ patternPairs
]

{ #category : 'visiting - inline elements' }
MicRuleAllTextChecker >> prepareForChecking [
	"in the future we should have multiple rules and managed this better"
	
	| r |
	r := rules first.
	patternPairs := r matchingPatterns collect: [ :each | each -> r ].
]

{ #category : 'visiting - inline elements' }
MicRuleAllTextChecker >> visitText: aMicText [

	self checkText: aMicText
]
