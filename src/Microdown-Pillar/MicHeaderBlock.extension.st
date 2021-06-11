Extension { #name : #MicHeaderBlock }

{ #category : #'*Microdown-Pillar' }
MicHeaderBlock >> closeMe [
	super closeMe.
	children :=  self inlineParse: children

]
