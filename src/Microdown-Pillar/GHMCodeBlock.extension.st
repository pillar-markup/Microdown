Extension { #name : #GHMCodeBlock }

{ #category : #'*Microdown-Pillar' }
GHMCodeBlock >> asPillar [
	^ PRCodeblock new
		language: self arguments;
		text: self code;
		yourself
]
