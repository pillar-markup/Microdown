Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [

	| prBlock par pillars |
	prBlock := PRCodeblock new.
	prBlock text: self code.

	self arguments keysAndValuesDo: [ :k :v | 
		v isEmptyOrNil 
			ifTrue: [ prBlock parameterAt: k put: true ]
			ifFalse: [ prBlock parameterAt: k put: v ]
		 ].
	
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
