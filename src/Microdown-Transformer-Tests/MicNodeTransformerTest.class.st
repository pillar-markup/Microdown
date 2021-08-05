Class {
	#name : #MicNodeTransformerTest,
	#superclass : #TestCase,
	#instVars : [
		'transformer'
	],
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #running }
MicNodeTransformerTest >> setUp [
	super setUp.
	transformer := MicNodeTransformerMock new

]

{ #category : #tests }
MicNodeTransformerTest >> testDeleteNode [

	| mic |
	mic := MicroDownParser new parse: '```
this is a paragraph
```'.
	self assert: mic children first class equals: MicCodeBlock.
	transformer visit: mic.
	self assert: mic children size equals: 0
]

{ #category : #tests }
MicNodeTransformerTest >> testReplaceNodeByAnotherNode [

	| mic |
	mic := MicroDownParser new parse: 'this is a paragraph'.
	self assert: mic children first class equals: MicParagraphBlock.
	transformer visit: mic.
	self assert: mic children first class equals: MicTextBlock.
	self assert: mic children first substring equals: 'test'
]
