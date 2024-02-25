Extension { #name : 'MicRelativeResourceReference' }

{ #category : '*Microdown-HTMLExporter' }
MicRelativeResourceReference >> uri [
	"Answer the receiver's reference in a uri (ZnUrl)."

	^ self path asZnUrl
]
