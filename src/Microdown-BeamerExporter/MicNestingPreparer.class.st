Class {
	#name : 'MicNestingPreparer',
	#superclass : 'Object',
	#instVars : [
		'currentHeader',
		'currentFollowers',
		'store'
	],
	#category : 'Microdown-BeamerExporter',
	#package : 'Microdown-BeamerExporter'
}

{ #category : 'initialization' }
MicNestingPreparer >> initialize [

	super initialize.
	store := IdentityDictionary new. 
	currentFollowers := OrderedCollection new. 
	
]

{ #category : 'as yet unclassified' }
MicNestingPreparer >> store [
	^ store
]

{ #category : 'as yet unclassified' }
MicNestingPreparer >> storePastElements [

	currentHeader ifNotNil: [ 
		store at: currentHeader put: currentFollowers.
		currentFollowers := OrderedCollection new ]
]

{ #category : 'visiting' }
MicNestingPreparer >> treatElement: each [
	
	each class = MicHeaderBlock
		ifTrue: [ 
					self storePastElements. 
					currentHeader := each ]
		ifFalse: [ currentFollowers addLast: each  ]
]

{ #category : 'as yet unclassified' }
MicNestingPreparer >> treatElements: aCol [

	aCol do: [ :each | self treatElement: each ].
	self storePastElements. 
]
