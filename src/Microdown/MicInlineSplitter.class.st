"
I represent the class which is in charge of splitting sentences to parse inline blocks.

To proceed: `GHMInlineSplitter new start: stringToParse`
"
Class {
	#name : #MicInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'string',
		'resultArray',
		'index',
		'delimiterStack',
		'allDelimiters'
	],
	#category : #'Microdown-Model'
}

{ #category : #'class references' }
MicInlineSplitter >> abstractDelimiterClass [
	^ MicAbstractDelimiter
]

{ #category : #accessing }
MicInlineSplitter >> allDelimiters [
	^ allDelimiters
]

{ #category : #process }
MicInlineSplitter >> delimiterFoundProcess: aDelimiterSubclass [
	delimiterStack add: (aDelimiterSubclass index: index)
]

{ #category : #process }
MicInlineSplitter >> emphasisProcess [
	resultArray := self emphasisProcessClass startWithStack: delimiterStack withString: string.
	^ resultArray
]

{ #category : #'class references' }
MicInlineSplitter >> emphasisProcessClass [
	^ MicInlineEmphasisProcess
]

{ #category : #accessing }
MicInlineSplitter >> index [
	^ index
]

{ #category : #actions }
MicInlineSplitter >> indexIncrement [
	^ self indexIncrement: 1
]

{ #category : #actions }
MicInlineSplitter >> indexIncrement: anInteger [
	index := self index + anInteger
]

{ #category : #initialization }
MicInlineSplitter >> initialize [
	super initialize.
	self initializeDelimiters
]

{ #category : #initialization }
MicInlineSplitter >> initializeDelimiters [
	allDelimiters := Dictionary new.
	self abstractDelimiterClass subclasses 
		select: [ :subclass | subclass isActive ]
		thenDo: [ :subclass | allDelimiters 
										at: subclass markup 
										put: (self class environment at: subclass name) ].
]

{ #category : #process }
MicInlineSplitter >> linkOrImageProcess [
	| linkNameCloserIndex |
	"1. search the linkname closer delimiter"
	linkNameCloserIndex := delimiterStack findLast: [ :delimiter | delimiter isOpener and: delimiter type = #linkName].
]

{ #category : #actions }
MicInlineSplitter >> read: aString [
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
MicInlineSplitter >> start: aString [
	delimiterStack := Stack new.
	resultArray := LinkedList new.
	index := 1.
	string := aString.
	^ self read: aString
]
