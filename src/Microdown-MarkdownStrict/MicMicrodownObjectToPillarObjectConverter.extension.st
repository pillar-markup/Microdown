Extension { #name : #MicMicrodownObjectToPillarObjectConverter }

{ #category : #'*Microdown-MarkdownStrict' }
MicMicrodownObjectToPillarObjectConverter >> visitLineBreak: aBreak [ 

	^ PRLineBreak new
]

{ #category : #'*Microdown-MarkdownStrict' }
MicMicrodownObjectToPillarObjectConverter >> visitRawParagraph: aRawParagraph [ 

	^ PRRaw content: aRawParagraph text
]
