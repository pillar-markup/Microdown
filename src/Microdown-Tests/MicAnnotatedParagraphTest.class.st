Class {
	#name : 'MicAnnotatedParagraphTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphIgnoreExtraTextInFirstLine [

	| root annotatedParagraph |
	root := parser parse: '>[! important ] This is an important information
> This is an other information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an other information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWhitoutClosingBracket [

	| root annotatedParagraph |
	root := parser parse: '>[! important
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicBlockQuoteBlock)
]
