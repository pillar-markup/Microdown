"
I represent blocks whose contents is not microdown markup as such.
"
Class {
	#name : #MicUnEvaluatedBlock2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'bodystring'
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

{ #category : #accessing }
MicUnEvaluatedBlock2 >> bodystring [

	^ bodystring
]

{ #category : #accessing }
MicUnEvaluatedBlock2 >> bodystring: anObject [

	bodystring := anObject
]

{ #category : #printing }
MicUnEvaluatedBlock2 >> printOn: stream [
	stream << self blockName << '(' << bodystring << ')'
	
]

{ #category : #obsolete }
MicUnEvaluatedBlock2 >> substring [
	self flag: 'to be obsoleted, use bodystring'.
	^ bodystring
]
