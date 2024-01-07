Extension { #name : #MicFigureBlock }

{ #category : #'*Microdown-HTMLExporter' }
MicFigureBlock >> altText [
	^ (self children collect: #plainText) joinUsing: ' '
]
