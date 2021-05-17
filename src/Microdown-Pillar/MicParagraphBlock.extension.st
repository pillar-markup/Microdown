Extension { #name : #MicParagraphBlock }

{ #category : #'*Microdown-Pillar' }
MicParagraphBlock >> asPillar [
	^ PRParagraph  new
		setChildren: (self pillarFromString: text);
		yourself
]

{ #category : #'*Microdown-Pillar' }
MicParagraphBlock >> closeMe [ 

	self children: (MicInlineSplitter new start: text).
]
