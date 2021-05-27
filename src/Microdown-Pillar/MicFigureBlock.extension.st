Extension { #name : #MicFigureBlock }

{ #category : #'*Microdown-Pillar' }
MicFigureBlock >> asPillar [
	| aPRFigure |
	aPRFigure := super asPillar.
	^ aPRFigure label: self substring; parameters: self parameters; yourself
]

{ #category : #'*Microdown-Pillar' }
MicFigureBlock >> associatedPillarClass [
	^PRFigure
]
