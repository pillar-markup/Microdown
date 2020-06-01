Class {
	#name : #MicLinkInlineBlock,
	#superclass : #MicAbstractInlineBlockWithUrl,
	#category : #'Microdown-Model'
}

{ #category : #'pillar conversion' }
MicLinkInlineBlock class >> associatedPRClass [
	^ PRExternalLink
]
