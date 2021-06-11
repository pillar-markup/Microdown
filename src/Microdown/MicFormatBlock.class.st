Class {
	#name : #MicFormatBlock,
	#superclass : #MicInlineElement,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicFormatBlock >> text [
	self flag: #fixMe. 
	"we should clarify what is text! to me it makes no sense."
 	^ String streamContents: [:st | self wrappedElements do: [ :each | st nextPutAll: each text ]]
]

{ #category : #accessing }
MicFormatBlock >> wrappedElement [
	^ children first
]

{ #category : #accessing }
MicFormatBlock >> wrappedElements [
	^ children
]
