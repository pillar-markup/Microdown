"
I'm a special inline block representing the fact that there is not markup. 
"
Class {
	#name : #MicTextBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicTextBlock >> accept: aVisitor [
	^ aVisitor visitText: self
]
