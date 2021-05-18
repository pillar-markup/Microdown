Extension { #name : #MicParagraphBlock }

{ #category : #'*Microdown-Pillar' }
MicParagraphBlock >> asPillar [
	^ PRParagraph  new
		setChildren: (self pillarFromString: text);
		yourself
]

{ #category : #'*Microdown-Pillar' }
MicParagraphBlock >> closeMe [

	super closeMe.
	self children: (self inlineParse: text)
]
