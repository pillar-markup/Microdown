Extension { #name : #MicFigureBlock2 }

{ #category : #'*Microdown-HTMLExporter' }
MicFigureBlock2 >> altText [
	^ (self children collect: #plainText) joinUsing: ' '
]
