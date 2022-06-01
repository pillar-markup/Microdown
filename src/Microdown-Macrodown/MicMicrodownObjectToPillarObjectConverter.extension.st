Extension { #name : #MicMicrodownObjectToPillarObjectConverter }

{ #category : #'*Microdown-Macrodown' }
MicMicrodownObjectToPillarObjectConverter >> visitLineBreak: aBreak [ 

	^ PRLineBreak new
]

{ #category : #'*Microdown-Macrodown' }
MicMicrodownObjectToPillarObjectConverter >> visitRawParagraph: aRawParagraph [ 

	^ PRRaw content: aRawParagraph text
]
