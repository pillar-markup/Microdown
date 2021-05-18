Extension { #name : #MicAbstractInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlockWithUrl >> asPillar [
	^ self associatedPillarClass new
		setChildren: (( self inlineParse: self substring) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
