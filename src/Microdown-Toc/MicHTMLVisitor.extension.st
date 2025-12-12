Extension { #name : 'MicHTMLVisitor' }

{ #category : '*Microdown-Toc' }
MicHTMLVisitor >> visitToCEntry: aMicTocEntry [ 
	
	aMicTocEntry header headerElements do: 
			[:each | each accept: self]

]
