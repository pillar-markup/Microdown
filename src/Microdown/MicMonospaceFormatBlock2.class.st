"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : #MicMonospaceFormatBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicMonospaceFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : #printing }
MicMonospaceFormatBlock2 >> printOn: aStream [

	self printWithoutConventions: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: substring.
	aStream nextPut: $)
]
