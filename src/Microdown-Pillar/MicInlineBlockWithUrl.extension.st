Extension { #name : #MicInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
MicInlineBlockWithUrl >> asPillar [
	^(self class pillarNodeFromKind: self kind) new
		setChildren: ( (MicIntraBlockSplitter new splitString: self literal) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
