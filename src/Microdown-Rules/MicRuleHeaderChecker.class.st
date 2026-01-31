Class {
	#name : 'MicRuleHeaderChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'strategy',
		'uncapitalizableText',
		'unlowercasableText'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'initialization' }
MicRuleHeaderChecker >> addUncapitalized: aString [ 
	"Make sure that aString will not be capitalized"
	
	uncapitalizableText add: aString
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkFirstWord: aCollection of: anElement [

	aCollection first isCapitalized ifFalse: [
			results add: (MicFirstElementOfHeaderIsNotCapitalizedResult new
					 micElement: anElement;
					 detail: aCollection first;
					 inFile: anElement fromFile) ]
]

{ #category : 'visiting' }
MicRuleHeaderChecker >> checkRest: words of: aMicHeader [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	
	strategy checkRest: words of: aMicHeader
]

{ #category : 'initialization' }
MicRuleHeaderChecker >> initialize [

	super initialize.
	self verifyLowercase.
	uncapitalizableText := OrderedCollection new.
	unlowercasableText := OrderedCollection new. 
	#( 'a' 'an' 'both' 'the' 'and' 'as' 'at' 'but' 'by' 'down'
	     'for' 'from' 'if' 'in' 'into' 'like' 'near' 'nor' 'of' 'off'
	     'on' 'one' 'once' 'onto' 'or' 'over' 'past' 'so' 'than' 'that' 'to'
	     'upon' 'when' 'with' 'yet' ) do: [ :each | self addUncapitalized: each ].
]

{ #category : 'as yet unclassified' }
MicRuleHeaderChecker >> shouldCapitalizedWord: aString [

	^ (uncapitalizableText includes: aString) not
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
