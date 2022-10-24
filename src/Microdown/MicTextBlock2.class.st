"
I'm a special inline block representing the fact that there is not markup. 
"
Class {
	#name : #MicTextBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #printing }
MicTextBlock2 >> printOn: aStream [

	self printWithoutConventions: aStream.
	self print: self substring surroundedOn: aStream.

]
