Extension { #name : #String }

{ #category : #'*Microdown' }
String >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]
