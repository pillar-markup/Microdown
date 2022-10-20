Extension { #name : #String }

{ #category : #'*Microdown' }
String >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]

{ #category : #'*Microdown' }
String >> resolveDocument: document [
	^ self asMicResourceReference resolveDocument: document.
]

{ #category : #'*Microdown' }
String >> withoutPreTabs [
	"return a copy of me, without tabs in the begining "
	^ self trimLeft: [ :char | char = Character tab ]
]
