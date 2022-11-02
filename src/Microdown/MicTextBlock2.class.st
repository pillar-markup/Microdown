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

{ #category : #accessing }
MicTextBlock2 >> text [
	^ bodystring 
]
