Class {
	#name : 'MicRuleHeaderChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rules',
		'errors',
		'strategy'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicRuleHeaderChecker >> addError: anError [
	errors add: anError
]

{ #category : 'adding' }
MicRuleHeaderChecker >> addRule: aRule [ 
	rules add: aRule.
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkFirstWord: aCollection of: anElement [
	
	aCollection first isCapitalized 
		ifFalse: [ 
			errors add: (MicFirstElementOfHeaderIsNotCapitalizedReport new 
						micElement: anElement; 
						concern: aCollection first;
						inFile: anElement fromFile)			
						]
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkRest: words of: aMicHeader [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	
	strategy checkRest: words of: aMicHeader rule: rules first
]

{ #category : 'accessing' }
MicRuleHeaderChecker >> errors [
	^ errors
]

{ #category : 'initialization' }
MicRuleHeaderChecker >> initialize [ 

	super initialize.
	rules := OrderedCollection new. 
	errors := OrderedCollection new.
	self verifyLowercase.
]

{ #category : 'initialization' }
MicRuleHeaderChecker >> verifyLowercase [

	strategy := MicRuleLowercaseHeaderStrategy new.
	strategy checker: self
]

{ #category : 'initialization' }
MicRuleHeaderChecker >> verifyUppercase [

	strategy := MicRuleUppercaseHeaderStrategy new.
	strategy checker: self
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> visitHeader: aMicHeader [

	| words |
	words := aMicHeader text splitOn: Character space.
	self checkFirstWord: words of: aMicHeader. 
	self checkRest: words of: aMicHeader. 

]
