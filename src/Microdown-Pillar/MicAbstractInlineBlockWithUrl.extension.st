Extension { #name : #MicAbstractInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlockWithUrl >> asPillar [
	^ self associatedPillarClass new
		setChildren: ((MicInlineSplitter new parse: self substring) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
