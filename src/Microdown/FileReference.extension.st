Extension { #name : #FileReference }

{ #category : #'*Microdown' }
FileReference >> asMicResourceReference [ 
	^ MicFileResourceReference fromFileRef: self
]
