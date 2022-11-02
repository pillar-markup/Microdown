"
I'm abstract block for the logic of elements which are managed by a 

startMarkup
body 
endMarkup 

My subclass should define lineMarkup
"
Class {
	#name : #MicSameStartStopMarkupBlock,
	#superclass : #MicStartStopMarkupBlock,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicSameStartStopMarkupBlock class >> isAbstract [

	^ self == MicSameStartStopMarkupBlock
]

{ #category : #accessing }
MicSameStartStopMarkupBlock >> arguments [
	^ arguments
]

{ #category : #visiting }
MicSameStartStopMarkupBlock >> caption [
	self deprecated: 'Should only be used for test' transformWith: '`@rec caption' -> '`@rec testCaptionString'.
	^ self testCaptionString.
]

{ #category : #'accessing-delegated' }
MicSameStartStopMarkupBlock >> caption: aString [
	arguments at: #caption put: (self inlineParse: aString)
]

{ #category : #visiting }
MicSameStartStopMarkupBlock >> captionElements [
	^ arguments at: #caption ifAbsent: [ #() ]
]

{ #category : #public }
MicSameStartStopMarkupBlock >> closeMe [
	"The only case where the receiver contains a nested element is in its caption"
	
	super closeMe.
	body ifNil: [ body := '' ].
	self arguments
		at: #caption
		ifPresent: [ :cp | 
		arguments at: #caption put: (self inlineParse: cp) ]
]

{ #category : #accessing }
MicSameStartStopMarkupBlock >> hasCaption [
	^ arguments includesKey:  #caption
]

{ #category : #markups }
MicSameStartStopMarkupBlock >> lineStopMarkup [

	^ self lineStartMarkup
]

{ #category : #visiting }
MicSameStartStopMarkupBlock >> testCaptionString [

	^ (self arguments at: #caption ifAbsent: [ ^'No Caption' ]) printString
]
