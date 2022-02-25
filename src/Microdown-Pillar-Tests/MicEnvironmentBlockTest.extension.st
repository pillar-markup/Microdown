Extension { #name : #MicEnvironmentBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicEnvironmentBlockTest >> testEnvironmentBlockAsPillar [
	| source root pillar |
	source := '<!environment|name=aName
Hello this is a dull body.
!>'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PREnvironment
	
]

{ #category : #'*Microdown-Pillar-Tests' }
MicEnvironmentBlockTest >> testEnvironmentBlockWithParametersAsPillar [
	| source root pillar |
	source := '<!environment|toto=22&name=isAlreadyDefined
Hello this is a dull body.
!>'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PREnvironment.
	self assert: (pillar parameterAt: 'toto') equals: '22'.
	self assert: (pillar parameterAt: 'name') equals: 'isAlreadyDefined'
	
]
