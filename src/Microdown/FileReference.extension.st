Extension { #name : 'FileReference' }

{ #category : '*Microdown' }
FileReference >> asMicResourceReference [ 
	^ MicFileResourceReference fromFileRef: self
]

{ #category : '*Microdown' }
FileReference >> resolveDocument: document [
	^ self asMicResourceReference resolveDocument: document.
]
