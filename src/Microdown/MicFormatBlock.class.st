Class {
	#name : #MicFormatBlock,
	#superclass : #MicInlineElement,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicFormatBlock >> wrappedElement [
	^ children first
]
