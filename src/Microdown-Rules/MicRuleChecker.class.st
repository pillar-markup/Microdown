Class {
	#name : 'MicRuleChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rules',
		'errors',
		'patternPairs'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'adding' }
MicRuleChecker >> addRule: aRule [ 
	rules add: aRule.
]

{ #category : 'as yet unclassified' }
MicRuleChecker >> checkText: aMicText [

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
MicRuleChecker >> errors [
	^ errors
]

{ #category : 'initialization' }
MicRuleChecker >> initialize [ 

	super initialize.
	rules := OrderedCollection new. 
	errors := OrderedCollection new.
]

{ #category : 'accessing' }
MicRuleChecker >> patterns [
	^ patternPairs
]

{ #category : 'visiting - inline elements' }
MicRuleChecker >> prepareForChecking [
	"in the future we should have multiple rules and managed this better"
	
	| r |
	r := rules first.
	patternPairs := r matchingPatterns collect: [ :each | each -> r ].
]

{ #category : 'visiting - inline elements' }
MicRuleChecker >> visitText: aMicText [

	self checkText: aMicText
]
