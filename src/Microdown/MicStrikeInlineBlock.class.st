Class {
	#name : #MicStrikeInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'pillar conversion' }
MicStrikeInlineBlock class >> associatedPRClass [
	^ PRStrikethroughFormat
]
