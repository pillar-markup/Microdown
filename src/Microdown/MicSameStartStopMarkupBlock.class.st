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

{ #category : #accessing }
MicSameStartStopMarkupBlock >> arguments: aDictionary [
	self halt: 'Do not set this'.
	arguments := aDictionary
]

{ #category : #visiting }
MicSameStartStopMarkupBlock >> caption [
	^ String streamContents: [:s |  self captionElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : #'accessing-delegated' }
MicSameStartStopMarkupBlock >> caption: aString [
	
	arguments at: #caption put: (MicInlineParser new parse: aString)
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
