Class {
	#name : 'MicRuleHeaderChecker',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'rules',
		'errors'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'adding' }
MicRuleHeaderChecker >> addRule: aRule [ 
	rules add: aRule.
]

{ #category : 'as yet unclassified' }
MicRuleHeaderChecker >> checkFirstWord: aCollection of: anElement [
	
	aCollection first first isUppercase
		ifFalse: [ 
			errors add: (MicFirstElementOfHeaderIsNotCapitalizedReport new 
						micElement: anElement; 
						inFile: anElement fromFile). 
						
						]
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
]

{ #category : 'visiting - inline elements' }
MicRuleHeaderChecker >> visitHeader: aMicHeader [

	| words |
	words := aMicHeader text splitOn: Character space.
	self checkFirstWord: words of: aMicHeader. 
	"self checkRest: words."

]
