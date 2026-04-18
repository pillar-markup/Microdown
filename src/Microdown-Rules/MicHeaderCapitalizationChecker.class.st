"
I check that headers follow a consistent capitalization strategy (uppercase or lowercase).

The first word of a header is always capitalized.
Common words like 'a', 'an', 'the', 'and', etc. are not capitalized.

I can be configured in two modes:
- uppercase: all significiant words should be capitalized
- lowercase: only the first word should be capitalized
"
Class {
	#name : 'MicHeaderCapitalizationChecker',
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

{ #category : 'public - name' }
MicHeaderCapitalizationChecker class >> checkerName [

	^ 'HeaderCapitalization'
]

{ #category : 'configuration help' }
MicHeaderCapitalizationChecker class >> configurationJSONPart [
	
	^ { ('uppercase' -> true) . ('keepAs' -> { 'mini' . 'uMicro'  }) } asDictionary
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> addUncapitalized: aString [ 
	"Make sure that aString will not be capitalized"
	
	uncapitalizableText add: aString
]

{ #category : 'visiting' }
MicHeaderCapitalizationChecker >> checkFirstWord: aCollection of: anElement [

	aCollection first isCapitalized ifFalse: [
			results add: (MicFirstElementOfHeaderIsNotCapitalizedResult new
					 micElement: anElement;
					 detail: aCollection first;
					 inFile: anElement fromFile) ]
]

{ #category : 'visiting' }
MicHeaderCapitalizationChecker >> checkRest: words of: aMicHeader [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	
	strategy checkRest: words of: aMicHeader
]

{ #category : 'configuration' }
MicHeaderCapitalizationChecker >> configureFrom: aConfiguration [
	aConfiguration isNil ifTrue: [ ^ self ].
	aConfiguration = 'uppercase'
		ifTrue: [ self verifyUppercase ]
		ifFalse: [ self verifyLowercase ]
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> initialize [

	super initialize.
	self verifyLowercase.
	uncapitalizableText := OrderedCollection new.
	unlowercasableText := OrderedCollection new. 
	#( 'a' 'an' 'both' 'the' 'and' 'as' 'at' 'but' 'by' 'down'
	     'for' 'from' 'if' 'in' 'into' 'like' 'near' 'nor' 'of' 'off'
	     'on' 'one' 'once' 'onto' 'or' 'over' 'past' 'so' 'than' 'that' 'to'
	     'upon' 'when' 'with' 'yet' ) do: [ :each | self addUncapitalized: each ].
]

{ #category : 'asserting' }
MicHeaderCapitalizationChecker >> shouldCapitalizedWord: aString [
	| normalized |
	normalized := (aString select: [ :c | c isLetter ]) asLowercase.

	^ (uncapitalizableText includes: normalized) not
]

{ #category : 'accessing' }
MicHeaderCapitalizationChecker >> strategy [

	^ strategy
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> verifyLowercase [

	strategy := MicRuleLowercaseHeaderStrategy new.
	strategy checker: self
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> verifyUppercase [

	strategy := MicRuleUppercaseHeaderStrategy new.
	strategy checker: self
]

{ #category : 'asserting' }
MicHeaderCapitalizationChecker >> visitHeader: aMicHeader [

	| words |
	words := aMicHeader text substrings.
	self checkFirstWord: words of: aMicHeader. 
	self checkRest: words of: aMicHeader. 

]
