Extension { #name : #MicHeaderBlock }

{ #category : #'*Microdown-Pillar' }
MicHeaderBlock >> asPillar [
	^ PRHeader new
		level: self level;
		setChildren: (children collect: [:each | each asPillar ]);
		yourself
]

{ #category : #'*Microdown-Pillar' }
MicHeaderBlock >> closeMe [
	super closeMe.
	children := (MicInlineSplitter new start: children)

]
