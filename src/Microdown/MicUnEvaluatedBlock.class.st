"
I represent blocks whose contents is not microdown markup as such.
"
Class {
	#name : 'MicUnEvaluatedBlock',
	#superclass : 'MicInlineElement',
	#instVars : [
		'bodystring'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'testing' }
MicUnEvaluatedBlock class >> isEvaluated [
	^ false
]

{ #category : 'parsing' }
MicUnEvaluatedBlock class >> parse: delimiter stream: aTokenStream for: aParser [
	^ aParser parseNonEvaluatedBlock: self token: delimiter stream: aTokenStream
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> bodystring [

	^ bodystring
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> bodystring: anObject [

	bodystring := anObject
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> children [
	"to be nicely polymorphic all nodes have children"
	^#()
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> children: newChildren [
	"to be nicely polymorphic all nodes have children"
]

{ #category : 'printing' }
MicUnEvaluatedBlock >> plainText [
	^ bodystring 
]

{ #category : 'printing' }
MicUnEvaluatedBlock >> printOn: stream [
	stream << self blockName << '(' << bodystring << ')'
	
]

{ #category : 'obsolete' }
MicUnEvaluatedBlock >> substring [
	self flag: 'to be obsoleted, use bodystring'.
	^ bodystring
]
