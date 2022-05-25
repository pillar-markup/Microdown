Extension { #name : #MicrodownVisitor }

{ #category : #'*Microdown-MarkdownStrict' }
MicrodownVisitor >> visitLineBreak: aBreak [ 

]

{ #category : #'*Microdown-MarkdownStrict' }
MicrodownVisitor >> visitRawParagraph: aRawParagraph [ 

	^ self visitChildrenOf: aRawParagraph
]
