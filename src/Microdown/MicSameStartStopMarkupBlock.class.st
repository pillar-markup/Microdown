"
I'm abstract block for the logic of elements which are managed by a 

startMarkup
body 
endMarkup 

My subclass should define lineMarkup
"
Class {
	#name : 'MicSameStartStopMarkupBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#instVars : [
		'arguments'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'testing' }
MicSameStartStopMarkupBlock class >> isAbstract [

	^ self == MicSameStartStopMarkupBlock
]

{ #category : 'accessing' }
MicSameStartStopMarkupBlock >> arguments [
	^ arguments
]

{ #category : 'visiting' }
MicSameStartStopMarkupBlock >> caption [
	^ (self arguments at: #caption ifAbsent: [ ^'No Caption' ]) printString
]

{ #category : 'accessing - delegated' }
MicSameStartStopMarkupBlock >> caption: aString [
	arguments at: #caption put: (self inlineParse: aString)
]

{ #category : 'visiting' }
MicSameStartStopMarkupBlock >> captionElements [
	^ arguments at: #caption ifAbsent: [ #() ]
]

{ #category : 'public' }
MicSameStartStopMarkupBlock >> closeMe [
	"The only case where the receiver contains a nested element is in its caption"
	
	super closeMe.
	body ifNil: [ body := '' ].
	self arguments
		at: #caption
		ifPresent: [ :cp | 
		 self caption: cp ]
]

{ #category : 'accessing' }
MicSameStartStopMarkupBlock >> hasCaption [
	^ arguments includesKey:  #caption
]

{ #category : 'markups' }
MicSameStartStopMarkupBlock >> lineStopMarkup [

	^ self lineStartMarkup
]

{ #category : 'visiting' }
MicSameStartStopMarkupBlock >> testCaptionString [
	self deprecated: 'Use caption' transformWith: '`@rec testCaptionString' -> '`@rec caption'.
	^ self caption
]
