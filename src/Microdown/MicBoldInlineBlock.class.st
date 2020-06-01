Class {
	#name : #MicBoldInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-Model'
}

{ #category : #'pillar conversion' }
MicBoldInlineBlock class >> associatedPRClass [
	^ PRBoldFormat
]
