Extension { #name : #MicBasicInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicBasicInlineBlock >> asPillar [
	^ PRText new text: self substring ; yourself 
]
