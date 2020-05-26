"
A GHMRootBlockTest is a test class for testing the behavior of GHMRootBlock
"
Class {
	#name : #MicRootBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
MicRootBlockTest >> testRootCanConsumeLine [
	"a root block can consume anything"
	
	| rootNode | 
	rootNode := MicRootBlock new.
	self assert: (rootNode canConsumeLine: '#').
	self assert: (rootNode canConsumeLine: '- ')
]

{ #category : #tests }
MicRootBlockTest >> testShowStructure [

	| source root |
	source := 'This is
a paragraph on two lines'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	self assert: (root showStructure: 0) equals:  
'MicRootBlock
	MicParagraphBlock
'
]
