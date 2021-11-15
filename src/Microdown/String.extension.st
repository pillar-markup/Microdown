Extension { #name : #String }

{ #category : #'*Microdown' }
String >> asMicResourceUri [
	^ MicResourceReference fromUri: self
]
