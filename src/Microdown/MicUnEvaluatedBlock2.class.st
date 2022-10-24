"
I represent blocks whose contents is not microdown markup as such.
"
Class {
	#name : #MicUnEvaluatedBlock2,
	#superclass : #MicInlineElement2,
	#category : #'Microdown-InlineParser'
}

{ #category : #testing }
MicUnEvaluatedBlock2 class >> isEvaluated [
	^ false
]

{ #category : #parsing }
MicUnEvaluatedBlock2 class >> parse: delimiter stream: aTokenStream for: aParser [
	^ aParser parseNonEvaluatedBlock: self token: delimiter stream: aTokenStream
]
