"
I'm a special inline block representing the fact that there is not markup. 
"
Class {
	#name : #MicTextBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicTextBlock2 >> accept: aVisitor [
	^ aVisitor visitText: self
]

{ #category : #obsolete }
MicTextBlock2 >> substring [
	"Should only be used for tests"
	self deprecated: 'Just use bodystring' transformWith: '`@rec substring' -> '`@rec bodystring'.
	^ bodystring 
]

{ #category : #obsolete }
MicTextBlock2 >> substring: aBody [
	"Should only be used for tests"
	self deprecated: 'Just use bodystring:' transformWith: '`@rec substring: `@arg' -> '`@rec bodystring: `@arg'.
	^ bodystring 
]

{ #category : #accessing }
MicTextBlock2 >> text [
	^ bodystring 
]
