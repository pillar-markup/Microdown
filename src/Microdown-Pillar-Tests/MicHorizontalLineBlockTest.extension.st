Extension { #name : 'MicHorizontalLineBlockTest' }

{ #category : '*Microdown-Pillar-Tests' }
MicHorizontalLineBlockTest >> testHorizontalLineBlockAsPillar [
	| source root pillar |
	source := '***
	'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PRHorizontalRule
	
]
