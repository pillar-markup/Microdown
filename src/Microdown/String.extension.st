Extension { #name : #String }

{ #category : #'*Microdown' }
String >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]

{ #category : #'*Microdown' }
String >> escapeAll [
	| escaped |
	escaped := String new: self size * 2.
	1 to: self size do: [ :idx | 
		escaped at: idx*2-1 put: $\. 
		escaped at: idx*2 put: (self at: idx)].
	^ escaped
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
