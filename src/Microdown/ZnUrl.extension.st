Extension { #name : 'ZnUrl' }

{ #category : '*Microdown' }
ZnUrl >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]

{ #category : '*Microdown' }
ZnUrl >> resolveDocument: document [
	^ self asMicResourceReference resolveDocument: document.
]
