"
A GHMBlockTextBlockTest is a test class for testing the behavior of GHMBlockTextBlock
"
Class {
	#name : #GHMQuoteBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMQuoteBlockTest >> testContents [
	| source root |
	source := '> text1
>    text2'.
	root := parser parse: source.
	self assert: root children first contents equals: '[ text1
text2 ]'
]

{ #category : #tests }
GHMQuoteBlockTest >> testNotLazy [
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
GHMQuoteBlockTest >> testQuoteBlockDoesNotInterpretOtherBlockMarkup [
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
GHMQuoteBlockTest >> testShowStructure [
	| source root |
	source := '> text1
>    text2'.
	root := parser parse: source.
	self assert: (root children first showStructure: 0) equals: 'GHMQuoteBlock
'
]

{ #category : #tests }
GHMQuoteBlockTest >> testSingleQuoteBlock [
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
GHMQuoteBlockTest >> testSingleQuoteBlockFollowedByList [
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
