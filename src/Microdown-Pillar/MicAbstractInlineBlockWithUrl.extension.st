Extension { #name : #MicAbstractInlineBlockWithUrl }

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlockWithUrl >> asPillar [
	^ self class associatedPRClass new
		setChildren: ((MicInlineSplitter new start: self substring) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]
