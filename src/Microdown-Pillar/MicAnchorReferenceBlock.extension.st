Extension { #name : #MicAnchorReferenceBlock }

{ #category : #'*Microdown-Pillar' }
MicAnchorReferenceBlock >> asPillar [

	^ PRInternalLink new anchor: substring; yourself
]

{ #category : #'*Microdown-Pillar' }
MicAnchorReferenceBlock >> associatedPillarClass [
	^ PRInternalLink
]
