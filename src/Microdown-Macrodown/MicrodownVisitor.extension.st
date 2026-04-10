Extension { #name : 'MicrodownVisitor' }

{ #category : '*Microdown-Macrodown' }
MicrodownVisitor >> visitLineBreak: aBreak [ 

]

{ #category : '*Microdown-Macrodown' }
MicrodownVisitor >> visitRawParagraph: aRawParagraph [ 

	^ self visitChildrenOf: aRawParagraph
]
