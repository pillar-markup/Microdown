Class {
	#name : 'MicFootnoteBlockTest',
	#superclass : 'MicAnnotationSubclassTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicFootnoteBlockTest >> testCreateTheRightFootnoteObject [

	| doc |
	doc := parser parse: '{!footnote|note=Duca99a!}'.
	self
		assert: doc children first children first class
		equals: MicFootnoteBlock.
	self
		assert: doc children first children first name
		equals: 'footnote'.
	self
		assert: (doc children first children first arguments at: #note)
		equals: 'Duca99a'
]
