"
I nest all the followers of a slide block into a slide block.
The idea is the following

```
slide 1
paragraph
header 2
....

slide 2
list
whatever
....
```

are turned into 

```
slide 1
	paragraph
	header 2
	....

slide 2
	list
	whatever
	....
```

where indentation means children of


"
Class {
	#name : 'MicNestingPreparer',
	#superclass : 'Object',
	#instVars : [
		'currentFollowers',
		'store',
		'currentSlide'
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

{ #category : 'acting' }
MicNestingPreparer >> storePastElements [

	currentSlide ifNotNil: [ 
		store at: currentSlide put: currentFollowers.
		currentFollowers := OrderedCollection new ]
]

{ #category : 'acting' }
MicNestingPreparer >> treatElement: each [
	
	each class = MicSlideBlock 
		ifTrue: [ 
					self storePastElements. 
					currentSlide := each ]
		ifFalse: [ currentFollowers addLast: each  ]
]

{ #category : 'as yet unclassified' }
MicNestingPreparer >> treatElements: aCol [

	aCol do: [ :each | self treatElement: each ].
	"we should not forget to handle the last elements are not followed by a slide"
	self storePastElements. 
]
