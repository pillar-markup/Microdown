Extension { #name : #MicTextBlock }

{ #category : #'*Microdown-Pillar' }
MicTextBlock >> asPillar [
	^ PRText new text: self substring ; yourself 
]

{ #category : #'*Microdown-Pillar' }
MicTextBlock >> associatedPillarClass [
	"special case"
]
