Extension { #name : #GHMUnorderedListBlock }

{ #category : #'*Microdown-Pillar' }
GHMUnorderedListBlock >> asPillar [
	^ PRUnorderedList new
		setChildren: (self children collect:[:child| child asPillar]);
		yourself
]
