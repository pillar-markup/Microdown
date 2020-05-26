"
I'm abstract block for the logic of elements which are managed by a 

startMarkup
body 
endMarkup 

My subclass should define lineMarkup
"
Class {
	#name : #GHMSameStartStopMarkupBlock,
	#superclass : #GHMStartStopMarkupBlock,
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMSameStartStopMarkupBlock class >> isAbstract [

	^ self == GHMSameStartStopMarkupBlock
]

{ #category : #markups }
GHMSameStartStopMarkupBlock >> lineStopMarkup [

	^ self lineStartMarkup
]
