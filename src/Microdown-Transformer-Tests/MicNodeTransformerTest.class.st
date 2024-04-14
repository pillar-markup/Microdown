Class {
	#name : 'MicNodeTransformerTest',
	#superclass : 'TestCase',
	#instVars : [
		'transformer'
	],
	#category : 'Microdown-Transformer-Tests',
	#package : 'Microdown-Transformer-Tests'
}

{ #category : 'running' }
MicNodeTransformerTest >> setUp [
	super setUp.
	transformer := MicNodeTransformerCodeDeleterMock new

]

{ #category : 'tests' }
MicNodeTransformerTest >> testDeleteNode [

	| root |
	root := Microdown parse: '```
this is a paragraph
```'.
	self assert: root children first class equals: MicCodeBlock.
	transformer visit: root.
	self assert: root children size equals: 0
]

{ #category : 'tests' }
MicNodeTransformerTest >> testReplaceNodeByAnotherNode [

	| root |
	root := Microdown parse: 'this is a paragraph'.
	self assert: root children first class equals: MicParagraphBlock.
	transformer visit: root.
	self assert: root children first class equals: MicTextBlock.
	self assert: root children first bodyString equals: 'test'
]
