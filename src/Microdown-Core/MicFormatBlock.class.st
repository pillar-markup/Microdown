Class {
	#name : #MicFormatBlock,
	#superclass : #MicInlineElement,
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicFormatBlock >> closeMe [
	
	| text |
	
	children ifEmpty: [
			text :=  (MicTextBlock
							from: start
							to: end
							withSubstring: substring
							withChildren: Array empty).
			self children: { text } ]
]

{ #category : #printing }
MicFormatBlock >> printOn: aStream [

	self printWithoutConventions: aStream.
	aStream nextPut: $(.
	self children ifNotNil: [ children do: [ :each | each printOn: aStream ] 
		separatedBy: [aStream nextPutAll: ' ']].
	aStream nextPut: $)
]

{ #category : #accessing }
MicFormatBlock >> text [

 	^ String streamContents: [:st | self wrappedElements do: [ :each | st nextPutAll: each text ]]
]

{ #category : #accessing }
MicFormatBlock >> textElement [
	^ children first
]

{ #category : #accessing }
MicFormatBlock >> textElement: aMicTextBlock [ 
	children := { aMicTextBlock }
]

{ #category : #accessing }
MicFormatBlock >> wrappedElements [
	^ children
]
