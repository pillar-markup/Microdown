Class {
	#name : #MicRawBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicRawBlockTest >> subjectClass [
	^ MicRawBlock  
]

{ #category : #tests }
MicRawBlockTest >> testRaw [

	| root |
	root := parser parse: 'it should be in a paragraph {{_Foo_}}'.
	self assert: root children first class equals: MicParagraphBlock.
	self
		assert: root children first children second class
		equals: MicRawBlock2
]
