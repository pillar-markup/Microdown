Extension { #name : #MicEnvironmentBlock }

{ #category : #'*Microdown-Pillar' }
MicEnvironmentBlock >> asPillar [
	^ self asPillarWithTag: name withParameters: arguments
]
