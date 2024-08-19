Class {
	#name : 'MicAnnotatedParagraphTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicAnnotatedParagraphTest >> subjectClass [ 
	^ MicAnnotatedParagraph 
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraph [

	| root annotatedParagraph |
	root := parser parse: '>[! important ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithALineBreak [

	| root annotatedParagraph |
	root := parser parse: '>[! important ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithANonSupportedLabel [

	| root annotatedParagraph |
	root := parser parse: '>[! test ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'note';
		assert: annotatedParagraph text
		equals: 'test This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithANonSupportedLabelWithUpperCase [

	| root annotatedParagraph |
	root := parser parse: '>[! Test ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'note';
		assert: annotatedParagraph text
		equals: 'Test This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithBlodText [

	| root annotatedParagraph |
	root := parser parse:
		        '>[! important ]
> This is an **important** information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph textElements size equals: 3;
		assert:
			(annotatedParagraph textElements second isKindOf:
					 MicBoldFormatBlock);
		assert: annotatedParagraph textElements second plainText
		equals: 'important'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithLabelHavingUpperCase [

	| root annotatedParagraph |
	root := parser parse: '>[! ImporTanT ]
> This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'important';
		assert: annotatedParagraph text
		equals: 'This is an important information'
]
