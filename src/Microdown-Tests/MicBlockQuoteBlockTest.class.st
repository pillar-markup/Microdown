"
I'm a test class for testing the behavior of MicBlockTextBlock
"
Class {
	#name : 'MicBlockQuoteBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicBlockQuoteBlockTest >> subjectClass [ 
	^ MicBlockQuoteBlock 
]

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testBasicQuoteBlock [
	| source root |
	source := '> test1
> test 2'.
	root := parser parse: source.

	self assert: root children first class equals: MicBlockQuoteBlock.
	self assert: root children first text  equals: 'test1
test 2'.
	self flag: #tofix.
"note that this is wrong because the body of a quoteblock is a paragraph and can containsTruePositive: formatting else this is just a code block"
]

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testBlockquoteBlockInterpretInlineELements [
    | source root text  |
    source := '> text1 **Bold bold**
>    text2'.
    root := parser parse: source.
    self assert: root children size equals: 1.
    text := root children first.
    self assert: text children first class equals: MicTextBlock. 
    self assert: text children second class equals: MicBoldFormatBlock. 
    self
        assert: text text
        equals:
            'text1 **Bold bold**
text2'
]

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testBlockquoteBlockInterpretInlineELementsOnMultipleLines [
    | source root text  |
    source := '> text1 **Bold 
>   bold** text2'.
    root := parser parse: source.
    self assert: root children size equals: 1.
    text := root children first.
    self assert: text children first class equals: MicTextBlock. 
    self assert: text children second class equals: MicBoldFormatBlock. 
    self assert: text children second plainText equals: 'Bold
bold'. 
    self assert: text children third class equals: MicTextBlock.  
]

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testNotLazy [
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

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testQuoteBlockDoesNotInterpretOtherBlockMarkup [
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

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testSingleQuoteBlock [
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

{ #category : 'tests' }
MicBlockQuoteBlockTest >> testSingleQuoteBlockFollowedByList [
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
