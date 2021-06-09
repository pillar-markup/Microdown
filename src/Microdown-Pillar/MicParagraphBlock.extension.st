Extension { #name : #MicParagraphBlock }

{ #category : #'*Microdown-Pillar' }
MicParagraphBlock >> closeMe [

	super closeMe.
	self children: (self inlineParse: text)
]
