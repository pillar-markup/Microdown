Extension { #name : #MicEnvironmentBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicEnvironmentBlockTest >> testEnvironmentBlockAsPillar [
	| source root pillar |
	source := '<?environment|name=aName?>'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PRUndefinedAnnotation
	
]
