"
I represent blocks with sub structure. Typically italics inside bold
"
Class {
	#name : 'MicEvaluatedBlock',
	#superclass : 'MicInlineElement',
	#instVars : [
		'children'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'parsing' }
MicEvaluatedBlock class >> blockName [
	^ (super blockName) "withoutSuffix: 'Format'"
]

{ #category : 'parsing' }
MicEvaluatedBlock class >> parse: token stream: aTokenStream for: aParser [
	^ aParser parseEvaluatedBlock: self token: token stream: aTokenStream
]

{ #category : 'accessing' }
MicEvaluatedBlock >> children [

	^ children
]

{ #category : 'accessing' }
MicEvaluatedBlock >> children: anObject [

	children := anObject
]

{ #category : 'printing' }
MicEvaluatedBlock >> plainText [
	^ (self children collect: #plainText) joinUsing: ' '
]

{ #category : 'printing' }
MicEvaluatedBlock >> printOn: stream [
	stream << self blockName << '{ '.
	children do: [ :ch | ch printOn: stream. stream nextPut: Character space  ].
	stream << $}
	
]

{ #category : 'accessing' }
MicEvaluatedBlock >> textElement [
	"Should only be used for tests"
	self deprecated: 'Just use children' transformWith: '`@rec textElement' -> '`@rec children first'.
	^ children first
]

{ #category : 'accessing' }
MicEvaluatedBlock >> textElement: elem [
	"Should only be used for tests"
	self deprecated: 'Just use children' transformWith: '`@rec textElement: `@arg' -> '`@rec children: {`@arg}'.
	^ children := { elem }
]

{ #category : 'accessing' }
MicEvaluatedBlock >> wrappedElements [
	self deprecated: 'Just use children' transformWith: '`@rec wrappedElements' -> '`@rec children'.
	^ children 
]
