Extension { #name : #GHMOrderedListBlock }

{ #category : #'*Microdown-Pillar' }
GHMOrderedListBlock >> asPillar [
	^ PROrderedList new
		setChildren: (self children collect: [ :child | child asPillar ]);
		counter: self startIndex;
		yourself
]
