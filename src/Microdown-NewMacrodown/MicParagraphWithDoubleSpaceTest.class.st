Class {
	#name : 'MicParagraphWithDoubleSpaceTest',
	#superclass : 'TestCase',
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : 'Microdown-NewMacrodown',
	#package : 'Microdown-NewMacrodown'
}

{ #category : 'running' }
MicParagraphWithDoubleSpaceTest >> testTwoSingleLinesWithSpaces [
	| root paragraph |
	self skip.
	root := MacrodownParser parse: 'This is  
a paragraph on two lines, separated by two spaces'.
	self assert: root children size equals: 1.
	paragraph := root children first. 

	self assert: paragraph children first text equals: 'This is'.
	self assert: paragraph children second class equals: MicLineBreakBlock.
	self assert: paragraph children third text equals: 'a paragraph on two lines, separated by two spaces'.
	self assert: paragraph text equals: 'This is
a paragraph on two lines, separated by two spaces'
]
