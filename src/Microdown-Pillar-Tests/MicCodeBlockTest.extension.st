Extension { #name : #MicCodeBlockTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicCodeBlockTest >> testSingleCodeBlockTwoLinesAsPillar [
	| source root code textBody argument |
	self skip. 
	"if you parse [[[smalltalk you obtain smalltalk->true but if convert ```smalltalk with asPillar you obtain smalltalk->nil"
	"the probleme resolved in language of PRCodeBlock but there is always a pb in the PRParser or asPillar"
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup. 
	root := self parser parse: source.
	code := root children first asPillar.
	self
		assert: code text
		equals:
			'my fancy code
is really cool'.
	self assert: code language originalName equals: 'ArgumentGoesHere'
]
