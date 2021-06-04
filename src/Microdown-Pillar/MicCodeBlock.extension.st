Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [

	| prBlock par pillars |
	prBlock := PRCodeblock new.
	prBlock text: self code.

	self arguments keysAndValuesDo: [ :k :v | 
		(arguments includesKey: #language)
			ifFalse: [ (arguments keys first = k and: v isEmptyOrNil)
				ifTrue: [ prBlock parameterAt: 'language' put: k ]
				 ifFalse:  [ prBlock parameterAt: k put: v ]  ]
			ifTrue: [prBlock parameterAt: k put: v ]].
	
	self hasCaption
		ifTrue: [ 
			prBlock parameters removeKey: #caption.
			par := PRParagraph new.
			pillars := self captionElements collect: [ :each | each asPillar ].
			pillars do: [ :each | par add: each ].
			prBlock setCaption: par ]
		ifFalse: [ 
			prBlock caption "Yes this is not an accessor but something with side effect" ].
	^ prBlock
]
