"
I represent blocks whose contents is not microdown markup as such.
"
Class {
	#name : #MicUnEvaluatedBlock2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'substring'
	],
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

{ #category : #printing }
MicUnEvaluatedBlock2 >> printOn: stream [
	stream << self blockName << '(' << substring << ')'
	
]

{ #category : #accessing }
MicUnEvaluatedBlock2 >> substring [

	^ substring
]

{ #category : #accessing }
MicUnEvaluatedBlock2 >> substring: anObject [

	substring := anObject
]
