Extension { #name : #MicAnnotatedBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotatedBlock >> asPillar [ 

	^ PRAnnotatedParagraph new 
			annotation: self label; 
			setChildren: (self pillarFrom: self textElements);
			yourself
]
