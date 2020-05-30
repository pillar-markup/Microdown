Extension { #name : #MicQuoteBlock }

{ #category : #'*Microdown-Pillar' }
MicQuoteBlock >> asPillar [

	^ PRPreformatted new
		setChildren: (self splitString: text);
		yourself
]
