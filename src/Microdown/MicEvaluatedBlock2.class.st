"
I represent blocks with sub structure. Typically italics inside bold
"
Class {
	#name : #MicEvaluatedBlock2,
	#superclass : #MicInlineElement2,
	#category : #'Microdown-InlineParser'
}

{ #category : #printing }
MicEvaluatedBlock2 >> printOn: aStream [

	self printWithoutConventions: aStream.
	aStream nextPut: $(.
	self children ifNotNil: [ children do: [ :each | each printOn: aStream ] 
		separatedBy: [aStream nextPutAll: ' ']].
	aStream nextPut: $)
]
