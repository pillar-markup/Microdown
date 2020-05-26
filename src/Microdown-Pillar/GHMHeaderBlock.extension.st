Extension { #name : #GHMHeaderBlock }

{ #category : #'*Microdown-Pillar' }
GHMHeaderBlock >> asPillar [
	^ PRHeader new
		level: self level;
		setChildren: (self splitString: header);
		yourself
]
