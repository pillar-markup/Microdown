"
I represent blocks whose contents is not microdown markup as such.
"
Class {
	#name : 'MicUnEvaluatedBlock',
	#superclass : 'MicInlineElement',
	#instVars : [
		'bodyString'
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
MicUnEvaluatedBlock >> bodyString [

	^ bodyString
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> bodyString: aString [

	bodyString := aString 
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> bodystring [
	"Should only be used for tests"
	self deprecated: 'Just use bodyString' transformWith: '`@rec bodystring' -> '`@rec bodyString'.
	^ bodyString 
]

{ #category : 'accessing' }
MicUnEvaluatedBlock >> bodystring: aString [
	"Should only be used for tests"
	self deprecated: 'Just use bodyString' transformWith: '`@rec bodystring: `@arg' -> '`@rec bodyString: `@arg'.
	bodyString := aString 
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
	^ bodyString 
]

{ #category : 'printing' }
MicUnEvaluatedBlock >> printOn: stream [
	stream << self blockName << '(' << bodyString << ')'
	
]

{ #category : 'obsolete' }
MicUnEvaluatedBlock >> substring [
	"Should only be used for tests"
	self deprecated: 'Just use bodystring' transformWith: '`@rec substring' -> '`@rec bodystring'.
	^ bodyString 
]
