Extension { #name : 'String' }

{ #category : '*Microdown' }
String >> asMicResourceReference [
	^ MicResourceReference fromUri: self
]

{ #category : '*Microdown' }
String >> escapeAll [
	| escaped |
	escaped := String new: self size * 2.
	1 to: self size do: [ :idx | 
		escaped at: idx*2-1 put: $\. 
		escaped at: idx*2 put: (self at: idx)].
	^ escaped
]

{ #category : '*Microdown' }
String >> resolveDocument: document [
	^ self asMicResourceReference resolveDocument: document.
]

{ #category : '*Microdown' }
String >> stripNtabs: n [
	"remove up to N tabs from the beginning"
	| count max |
	max := n min: self size.
	count := 1. "all charcters less than count are tabs"
	[ count <= max and: [ (self at: count) = Character tab ] ]
		whileTrue: [count := count + 1].
	^ self allButFirst: count-1
]

{ #category : '*Microdown' }
String >> withoutPreTabs [
	"return a copy of me, without tabs in the begining "
	^ self trimLeft: [ :char | char = Character tab ]
]
