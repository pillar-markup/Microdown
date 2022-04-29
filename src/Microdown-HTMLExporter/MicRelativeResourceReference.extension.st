Extension { #name : #MicRelativeResourceReference }

{ #category : #'*Microdown-HTMLExporter' }
MicRelativeResourceReference >> uri [

	^ self path asZnUrl
]
