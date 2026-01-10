Class {
	#name : 'MicRuleHeaderChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'strategy'
	],
	#category : 'Microdown-Rules-CapitalizationUnderway',
	#package : 'Microdown-Rules',
	#tag : 'CapitalizationUnderway'
}

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkFirstWord: aCollection of: anElement [

	aCollection first isCapitalized ifFalse: [
			results add: (MicFirstElementOfHeaderIsNotCapitalizedReport new
					 micElement: anElement;
					 concern: aCollection first;
					 inFile: anElement fromFile) ]
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkRest: words of: aMicHeader [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	
	strategy checkRest: words of: aMicHeader rule: rules first
]

{ #category : 'initialization' }
MicRuleHeaderChecker >> initialize [

	super initialize.
	self verifyLowercase
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
