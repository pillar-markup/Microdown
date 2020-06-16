Class {
	#name : #MicLinkInlineBlock,
	#superclass : #MicAbstractInlineBlockWithUrl,
	#category : #'Microdown-ModelInline'
}

{ #category : #'pillar conversion' }
MicLinkInlineBlock class >> associatedPRClass [
	^ PRExternalLink
]
