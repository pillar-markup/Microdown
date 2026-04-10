Class {
	#name : 'MicRawBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicRawBlockTest >> subjectClass [
	^ MicRawBlock  
]

{ #category : 'tests' }
MicRawBlockTest >> testRawBeginningOfLine [

	| root |
	root := parser parse: '{{ 
This is a raw paragraph
On two lines
}}'.
	
	self 
		assert: root children first children first class 
		equals: MicRawBlock.
	self 
		assert: root children first children first bodyString 
		equals: '
This is a raw paragraph
On two lines
'
]

{ #category : 'tests' }
MicRawBlockTest >> testRawDoesNotInterpretContents [

	| root |
	root := parser parse: 'it should be in a paragraph {{_Foo_}}'.
	self assert: root children first class equals: MicParagraphBlock.
	self
		assert: root children first children second class
		equals: MicRawBlock.
	self assert: root children first children second bodyString 
		equals: '_Foo_'
]
