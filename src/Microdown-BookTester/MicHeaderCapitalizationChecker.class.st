"
I check that headers follow a consistent capitalization strategy (uppercase or lowercase).

The first word of a header is always capitalized.
Common words like 'a', 'an', 'the', 'and', etc. are not capitalized.

I can be configured in two modes:
- uppercase: true all significiant words should be capitalized
- uppercase: false only the first word should be capitalized

In addition keepAs is a collection of words that should be changed in any mode. 
"
Class {
	#name : 'MicHeaderCapitalizationChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'strategy',
		'uncapitalizableText',
		'unlowercasableText',
		'keepAsIs'
	],
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'public - name' }
MicHeaderCapitalizationChecker class >> checkerName [

	^ 'HeaderCapitalization'
]

{ #category : 'configuration help' }
MicHeaderCapitalizationChecker class >> objectsForJSONConfigurationPart [
	
	^ { ('uppercase' -> true) . ('keepAs' -> { 'mini' . 'uDown'  }) } asDictionary
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> addUncapitalized: aString [ 
	"Make sure that aString will not be capitalized"
	
	uncapitalizableText add: aString
]

{ #category : 'visiting' }
MicHeaderCapitalizationChecker >> checkFirstWord: aCollection of: anElement [
	"Treat the first element of a sentence by uppercase except if the word
	is in the keep as is list"
	
	| first |
	first := aCollection first.
	(keepAsIs includes: first) ifTrue: [ ^ self ].
	first isCapitalized ifFalse: [
			results add: (MicFirstElementOfHeaderIsNotCapitalizedResult new
					 micElement: anElement;
					 detail: first;
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
	(aConfiguration includesKey: #uppercase) 
		ifTrue: [ (aConfiguration at: #uppercase)
						ifTrue: [ self verifyUppercase ]
						ifFalse: [ self verifyLowercase ]].
	aConfiguration at: #keepAs
		ifPresent: [ :aCol | keepAsIs := aCol collect: [ :each | each asString ] ] 
]

{ #category : 'initialization' }
MicHeaderCapitalizationChecker >> initialize [

	super initialize.
	self verifyLowercase.
	uncapitalizableText := Set new.
	unlowercasableText := OrderedCollection new. 
	#( 'a' 'an' 'both' 'the' 'and' 'as' 'at' 'but' 'by' 'down'
	     'for' 'from' 'if' 'in' 'into' 'like' 'near' 'nor' 'of' 'off'
	     'on' 'one' 'once' 'onto' 'or' 'over' 'past' 'so' 'than' 'that' 'to'
	     'upon' 'when' 'with' 'yet' ) do: [ :each | self addUncapitalized: each ].
	keepAsIs := Set new.
]

{ #category : 'accessing' }
MicHeaderCapitalizationChecker >> keepAsIs [
	^ keepAsIs
]

{ #category : 'accessing' }
MicHeaderCapitalizationChecker >> keepAsIs: aCollection [ 
	keepAsIs := aCollection
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
	
	words := words reject: [ :e | keepAsIs includes: e ].
	self checkRest: words of: aMicHeader
]
