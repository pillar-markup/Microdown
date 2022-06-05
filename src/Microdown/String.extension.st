Extension { #name : #String }

{ #category : #'*Microdown' }
String >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]

{ #category : #'*Microdown' }
String >> resolveDocument: document [
	^ self asMicResourceReference resolveDocument: document.
]
