Extension { #name : #GHMListItemBlock }

{ #category : #'*Microdown-Pillar' }
GHMListItemBlock >> asPillar [
	^ PRListItem new
		setChildren: (self splitString: text), (self children collect: [:child| child asPillar]);
		yourself
]
