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
	#name : 'MicSlideFollowerNester',
	#superclass : 'Object',
	#instVars : [
		'currentFollowers',
		'currentSlide'
	],
	#category : 'Microdown-BeamerExporter-Slide as header',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Slide as header'
}

{ #category : 'initialization' }
MicSlideFollowerNester >> initialize [

	super initialize.
	currentFollowers := OrderedCollection new. 
	
]

{ #category : 'acting' }
MicSlideFollowerNester >> storePastElements [
	"the past elements are now children of the current slide."
	
	currentSlide ifNotNil: [ 
		currentSlide children: currentFollowers.
		currentFollowers do: [ :each | currentSlide parent removeChild: each ].
		currentFollowers := OrderedCollection new ]
]

{ #category : 'acting' }
MicSlideFollowerNester >> treatElement: each [
	"When we face a new slide, we store the past seen elements as children of the current slide,
	else we just sotre the element as a past element."
	
	each class = MicSlideBlock 
		ifTrue: [ 
					self storePastElements. 
					currentSlide := each ]
		ifFalse: [ 
				currentFollowers addLast: each.
				"remove it from here"
				"each parent removeChild: each"  ]
]

{ #category : 'acting' }
MicSlideFollowerNester >> treatElements: aCol [

	"We copy the collection because we modify it somehow."
	aCol copy do: [ :each | self treatElement: each ].
	"we should not forget to handle the last elements are not followed by a slide"
	self storePastElements. 
]
