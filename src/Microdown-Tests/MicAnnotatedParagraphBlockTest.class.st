Class {
	#name : 'MicAnnotatedParagraphBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> subjectClass [ 
	^ MicAnnotatedParagraphBlock 
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testAnnotatedParagraphBreakingTheParser [

	| root annotatedParagraph |
	root := parser parse: '

>[! important]  I would like a piece of code here ] 
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testAnnotatedParagraphBreakingTheParser2 [

	| root annotatedParagraph |
	root := parser parse: '

>[! SD]  I would like a piece of code here
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'note';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraph [

	| root annotatedParagraph |
	root := parser parse: '>[! important ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphIgnoreExtraTextInFirstLine [

	| root annotatedParagraph |
	root := parser parse: '>[! important ] Let us be less silly
> This is an other information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an other information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWhitoutClosingBracket [

	| root annotatedParagraph |
	root := parser parse: '>[! important
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicBlockQuoteBlock)
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithALineBreak [

	| root annotatedParagraph |
	root := parser parse: '>[! important ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithANonSupportedLabel [

	| root annotatedParagraph |
	root := parser parse: '>[! test ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'note';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithBoldText [

	| root annotatedParagraph |
	root := parser parse:
		        '>[! important ]
> This is an **crucial** information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph textElements size equals: 3;
		assert:
			(annotatedParagraph textElements second isKindOf:
					 MicBoldFormatBlock);
		assert: annotatedParagraph textElements second plainText
		equals: 'crucial'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithLabelHavingUpperCase [

	| root annotatedParagraph |
	root := parser parse: '>[! ImporTanT ]
> This is a crucial information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is a crucial information'
]
