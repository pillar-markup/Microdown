Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Pillar' }
MicCodeBlock >> asPillar [
	
	| prBlock |
	prBlock := PRCodeblock new.
	prBlock text: self code.
	self arguments keysAndValuesDo: [ :k :v |
		prBlock parameterAt: k put: v
		 ].
	^ prBlock
		
]
