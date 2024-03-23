"
I'm a special inline block representing the fact that there is not markup. 
"
Class {
	#name : 'MicTextBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'visiting' }
MicTextBlock >> accept: aVisitor [
	^ aVisitor visitText: self
]

{ #category : 'obsolete' }
MicTextBlock >> bodystring [
	"Should only be used for tests"
	self deprecated: 'Just use bodyString' transformWith: '`@rec bodystring' -> '`@rec bodyString'.
	^ bodyString 
]

{ #category : 'obsolete' }
MicTextBlock >> substring [
	"Should only be used for tests"
	self deprecated: 'Just use bodystring' transformWith: '`@rec substring' -> '`@rec bodystring'.
	^ bodyString 
]

{ #category : 'obsolete' }
MicTextBlock >> substring: aBody [
	"Should only be used for tests"
	self deprecated: 'Just use bodystring:' transformWith: '`@rec substring: `@arg' -> '`@rec bodystring: `@arg'.
	^ bodyString 
]

{ #category : 'accessing' }
MicTextBlock >> text [
	^ bodyString 
]
