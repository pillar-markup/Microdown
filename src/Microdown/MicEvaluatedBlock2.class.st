"
I represent blocks with sub structure. Typically italics inside bold
"
Class {
	#name : #MicEvaluatedBlock2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'children'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #'as yet unclassified' }
MicEvaluatedBlock2 class >> blockName [
	^ (super blockName) "withoutSuffix: 'Format'"
]

{ #category : #parsing }
MicEvaluatedBlock2 class >> parse: token stream: aTokenStream for: aParser [
	^ aParser parseEvaluatedBlock: self token: token stream: aTokenStream
]

{ #category : #accessing }
MicEvaluatedBlock2 >> children [

	^ children
]

{ #category : #accessing }
MicEvaluatedBlock2 >> children: anObject [

	children := anObject
]

{ #category : #printing }
MicEvaluatedBlock2 >> printOn: stream [
	stream << self blockName << '{ '.
	children do: [ :ch | ch printOn: stream. stream nextPut: Character space  ].
	stream << $}
	
]

{ #category : #accessing }
MicEvaluatedBlock2 >> textElement [
	"Should only be used for tests"
	self deprecated: 'Just use children' transformWith: '`@rec textElement' -> '`@rec children first'.
	^ children first
]

{ #category : #accessing }
MicEvaluatedBlock2 >> textElement: elem [
	"Should only be used for tests"
	self deprecated: 'Just use children' transformWith: '`@rec textElement: `@arg' -> '`@rec children: {`@arg}'.
	^ children := { elem }
]

{ #category : #accessing }
MicEvaluatedBlock2 >> wrappedElements [
	self deprecated: 'Just use children' transformWith: '`@rec wrappedElements' -> '`@rec children'.
	^ children 
]
