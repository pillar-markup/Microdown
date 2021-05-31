"
I'm a test class for testing the behavior of MicBlockTextBlock
"
Class {
	#name : #MicQuoteBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicQuoteBlockTest >> testBasicQuoteBlock [
	| source root |
	self skip.
	"strange it looks like we drop text2"
	source := '> text1
>    text2'.
	root := parser parse: source.
	self assert: root children first class equals: MicCodeBlock.
	self assert: root children first
]

{ #category : #tests }
MicQuoteBlockTest >> testNotLazy [
	"the spec says that the last > could be omitted but we do not support it."
	| source root text  |
	source := '> text1
>   - text2
text3'.
	root := parser parse: source.
	self assert: root children size equals: 2.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
- text2'
]

{ #category : #tests }
MicQuoteBlockTest >> testQuoteBlockDoesNotInterpretOtherBlockMarkup [
	| source root text  |
	source := '> text1
>   - text2
> ```languague=pharo
> Yeah cool'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
- text2
```languague=pharo
Yeah cool'
]

{ #category : #tests }
MicQuoteBlockTest >> testSingleQuoteBlock [
	| source root text  |
	source := '> text1
>    text2'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
text2'
]

{ #category : #tests }
MicQuoteBlockTest >> testSingleQuoteBlockFollowedByList [
	| source root text list |
	source := '> text1
>    text2
1. first
2. second
3. third'.
	root := parser parse: source.
	self assert: root children size equals: 2.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
text2'.
	list := root children second.
	self assert: list children size equals: 3
]
