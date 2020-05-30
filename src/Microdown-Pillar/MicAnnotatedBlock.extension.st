Extension { #name : #MicAnnotatedBlock }

{ #category : #'*Microdown-Pillar' }
MicAnnotatedBlock >> asPillar [ 

	^ PRAnnotatedParagraph new 
			annotation: self label; 
			setChildren: (self splitString: self text);
			yourself
]
