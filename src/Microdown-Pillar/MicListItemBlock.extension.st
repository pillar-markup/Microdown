Extension { #name : #MicListItemBlock }

{ #category : #'*Microdown-Pillar' }
MicListItemBlock >> asPillar [
	^ PRListItem new
		setChildren: (self pillarFrom: self textElements), (self children collect: [:child| child asPillar]);
		yourself;
		yourself
]
