Extension { #name : #GHMParagraphBlock }

{ #category : #'*Microdown-Pillar' }
GHMParagraphBlock >> asPillar [
	^ PRParagraph  new
		setChildren: (self splitString: text);
		yourself
]
