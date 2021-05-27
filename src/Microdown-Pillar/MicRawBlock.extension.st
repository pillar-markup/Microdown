Extension { #name : #MicRawBlock }

{ #category : #'*Microdown-Pillar' }
MicRawBlock >> asPillar [
	^ PRRaw new text: self substring ; yourself 
]

{ #category : #'*Microdown-Pillar' }
MicRawBlock >> associatedPillarClass [
	^ PRRaw 
]
