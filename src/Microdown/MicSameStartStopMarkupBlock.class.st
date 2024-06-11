"
I'm an abstract block for the logic of elements which are managed by an identical start and stop markup. It can take a list of arguments.

For example:
```text
 ```language=text
 carpe   diem
 % verbatim
 ```
```
defines a block that uses the same start and end markup, with the 'text' language argument.

My subclasses should define `lineStartMarkup`, which is also used as the `lineStopMarkup`.
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
	^ arguments includesKey: #caption
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
