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
	root := parser parse: '!!Important This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'Important';
		assert: annotatedParagraph text equals: 'This is an important information'
]

{ #category : 'tests' }
MicAnnotatedParagraphTest >> testBasicAnnotetedParagraphWithALineBreak [

	| root annotatedParagraph |
	root := parser parse: '!!Important 
This is an important information'.
	self assert: root children size equals: 1.
	annotatedParagraph := root children first.
	self
		assert: (annotatedParagraph isKindOf: MicAnnotatedParagraph);
		assert: annotatedParagraph label equals: 'Important';
		assert: annotatedParagraph text equals: 'This is an important information'
]
