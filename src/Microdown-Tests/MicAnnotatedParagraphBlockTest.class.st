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
	root := parser parse: '>[! important ] This is an important information
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
		equals: 'test This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithANonSupportedLabelWithUpperCase [

	| root annotatedParagraph |
	root := parser parse: '>[! Test ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'note';
		assert: annotatedParagraph text
		equals: 'Test This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithBlodText [

	| root annotatedParagraph |
	root := parser parse:
		        '>[! important ]
> This is an **important** information'.
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
		equals: 'important'
]

{ #category : 'tests' }
MicAnnotatedParagraphBlockTest >> testBasicAnnotetedParagraphWithLabelHavingUpperCase [

	| root annotatedParagraph |
	root := parser parse: '>[! ImporTanT ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraphBlock);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]
