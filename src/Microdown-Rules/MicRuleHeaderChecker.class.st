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
	
	"words allButFirst allSatisfy: [ :each | each isCapitalized ]"
	words allButFirst do: [ :word |
		word isCapitalized 
			ifTrue: [  
				errors add: (MicFirstElementOfHeaderIsNotCapitalizedReport new 
								micElement: aMicHeader; 
								concern: word;
								inFile: aMicHeader fromFile) 
						]
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

{ #category : 'visiting' }
MicRuleHeaderChecker >> visitHeader: aMicHeader [

	| words |
	words := aMicHeader text splitOn: Character space.
	self checkFirstWord: words of: aMicHeader. 
	self checkRest: words of: aMicHeader. 

]
