Class {
	#name : #MicStrikeInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-Model'
}

{ #category : #'pillar conversion' }
MicStrikeInlineBlock class >> associatedPRClass [
	^ PRStrikethroughFormat
]
