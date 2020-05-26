Extension { #name : #GHMRootBlock }

{ #category : #'*Microdown-Pillar' }
GHMRootBlock >> asPillar [
	^ PRDocument new
		setChildren: (self children collect: [ :child | child asPillar ]);
		yourself
]
