Extension { #name : #MicAnchorBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicAnchorBlockTest >> testAnchorBlockAsPillar [
	| source root pillar |
	source := '@anchor'.
	root := parser parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PRAnchor
]
