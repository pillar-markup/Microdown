"
I represent the class which is in charge of splitting sentences to parse inline blocks.

To proceed: `GHMInlineSplitter new start: stringToParse`
"
Class {
	#name : #GHMInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'string',
		'resultArray',
		'index',
		'delimiterStack',
		'allDelimiters'
	],
	#category : #'Microdown-Model - inline'
}

{ #category : #'class references' }
GHMInlineSplitter >> abstractDelimiterClass [
	^ GHMAbstractDelimiter
]

{ #category : #accessing }
GHMInlineSplitter >> allDelimiters [
	^ allDelimiters
]

{ #category : #process }
GHMInlineSplitter >> delimiterFoundProcess: aDelimiterSubclass [
	(aDelimiterSubclass new type == 'linkNameCloser') 
		ifTrue: [ ^ self linkOrImageProcess ]			
		ifFalse: [ delimiterStack add: (aDelimiterSubclass index: index)]
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcess [
	resultArray := self emphasisProcessClass startWithStack: delimiterStack withString: string.
	^ resultArray
]

{ #category : #'class references' }
GHMInlineSplitter >> emphasisProcessClass [
	^ GHMInlineEmphasisProcess
]

{ #category : #accessing }
GHMInlineSplitter >> index [
	^ index
]

{ #category : #actions }
GHMInlineSplitter >> indexIncrement [
	^ self indexIncrement: 1
]

{ #category : #actions }
GHMInlineSplitter >> indexIncrement: anInteger [
	index := self index + anInteger
]

{ #category : #initialization }
GHMInlineSplitter >> initialize [
	super initialize.
	self initializeDelimiters
]

{ #category : #initialization }
GHMInlineSplitter >> initializeDelimiters [
	allDelimiters := Dictionary new.
	self flag: #torevisit. "why creating two times the class when we do not need at all."
	self abstractDelimiterClass subclasses 
		select: [ :subclass | subclass new isActive ] 
		thenDo: [ :subclass | allDelimiters 
										at: subclass new markup 
										put: (self class environment at: subclass name) ].
]

{ #category : #process }
GHMInlineSplitter >> linkOrImageProcess [
	| linkNameCloserIndex |
	"1. search the linkname closer delimiter"
	linkNameCloserIndex := delimiterStack findLast: [ :delimiter | delimiter isOpener and: delimiter type = #linkName].
]

{ #category : #actions }
GHMInlineSplitter >> read: aString [
	| incrementation |
	incrementation := 1.
	aString ifEmpty: [ ^ self emphasisProcess ].
	allDelimiters keysDo: [ :key | 
		(aString beginsWith: key) 
			ifTrue: [ 
				self delimiterFoundProcess: (allDelimiters at: key).
				incrementation := key size.
			].
	].
	self indexIncrement: incrementation.
	^ self read: (aString allButFirst: incrementation)
	
]

{ #category : #public }
GHMInlineSplitter >> start: aString [
	delimiterStack := Stack new.
	index := 1.
	string := aString.
	^ self read: aString
]
