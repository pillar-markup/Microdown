Extension { #name : #MicInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
MicInlineBlockWithUrl >> asPillar [
	^ self associatedPillarClass new
		setChildren: (( self inlineParse: self substring) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
