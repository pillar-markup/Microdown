Extension { #name : #Text }

{ #category : #'*Microdown' }
Text >> attributeAt: idx ofKind: aClass [
	(self attributesAt: idx)
			detect: [ :attr | attr isKindOf: aClass  ] 
			ifFound: [:attr | ^ attr  ].
	^nil
]
