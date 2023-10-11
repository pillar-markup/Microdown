Extension { #name : 'MicElement' }

{ #category : '*Microdown-Pillar' }
MicElement >> asPillar [

	^ self accept: MicMicrodownObjectToPillarObjectConverter new
]
