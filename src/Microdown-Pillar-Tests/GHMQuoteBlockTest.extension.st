Extension { #name : #GHMQuoteBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
GHMQuoteBlockTest >> testQuoteBlockAsPilar [
	| source root pillarNode |
	source := '> text1
>    text2'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	pillarNode := root children first asPillar.
	self flag: #fixme. "This is not an environment"
	self assert: pillarNode class equals: PREnvironment.
	self assert: pillarNode name equals: 'textBlock'.
	self
		assert: pillarNode text
		equals:
			'text1
text2'
]
