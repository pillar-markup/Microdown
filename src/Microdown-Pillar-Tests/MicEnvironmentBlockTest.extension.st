Extension { #name : #MicEnvironmentBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicEnvironmentBlockTest >> testEnvironmentBlockAsPillar [
	| source root pillar |
	source := '<?environment|name=aName
Hello this is a dull body.
?>'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PREnvironment
	
]
