Extension { #name : #GHMInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
GHMInlineBlockWithUrl >> asPillar [
	^(self class pillarNodeFromKind: self kind) new
		setChildren: ( (GHMIntraBlockSplitter new splitString: self literal) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
