Class {
	#name : 'MicNoteBlockTest',
	#superclass : 'MicAnnotationSubclassTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicNoteBlockTest >> testCreateTheRightNoteObject [

	| doc |
	doc := parser parse: '{!note|contents=Duca99a!}'.
	self assert: doc children first children first class equals: MicNoteBlock.
	self assert: doc children first children first name equals: 'note'.
	self assert: (doc children first children first arguments at: #contents) equals: 'Duca99a'.
]
