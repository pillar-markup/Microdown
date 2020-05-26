Extension { #name : #MicHeaderBlock }

{ #category : #'*Microdown-Pillar' }
MicHeaderBlock >> asPillar [
	^ PRHeader new
		level: self level;
		setChildren: (self splitString: header);
		yourself
]
