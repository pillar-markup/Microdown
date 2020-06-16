Class {
	#name : #MicBoldInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'pillar conversion' }
MicBoldInlineBlock class >> associatedPRClass [
	^ PRBoldFormat
]
