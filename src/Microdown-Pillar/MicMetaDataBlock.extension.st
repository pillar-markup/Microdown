Extension { #name : #MicMetaDataBlock }

{ #category : #'*Microdown-Pillar' }
MicMetaDataBlock >> asPillar [
	""
	self halt.
	^ PRMetadata new metadata: (STON fromString: self body); yourself
	
]
