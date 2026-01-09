Extension { #name : 'MicHTMLVisitor' }

{ #category : '*Microdown-Toc' }
MicHTMLVisitor >> visitTocEntry: aMicTocEntry [ 
	
	canvas tag
		name: 'li';
		with: [ 
			aMicTocEntry header headerElements do: 
						[:each | each accept: self] ].
	canvas newLine
]
