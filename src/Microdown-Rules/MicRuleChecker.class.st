Class {
	#name : 'MicRuleChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rules',
		'errors',
		'patterns'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'adding' }
MicRuleChecker >> addRule: aRule [ 
	rules add: aRule.
]

{ #category : 'as yet unclassified' }
MicRuleChecker >> checkText: aText [

	| foundProblems |
	foundProblems := patterns select: [ :each | each match: aText ].
	foundProblems do: [ :each | errors add: (MicUseofWrongVocabulary new
											text: aText;
											pattern: each) ]	
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
	^ patterns
]

{ #category : 'visiting - inline elements' }
MicRuleChecker >> prepareForChecking [
	"in the future we should have multiple rules and managed this better"
	patterns := rules first matchingPatterns 
]

{ #category : 'visiting - inline elements' }
MicRuleChecker >> visitText: aMicText [

	self checkText: aMicText bodyString
]
