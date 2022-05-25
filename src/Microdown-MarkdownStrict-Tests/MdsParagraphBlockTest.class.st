Class {
	#name : #MdsParagraphBlockTest,
	#superclass : #MicParagraphBlockTest,
	#category : #'Microdown-MarkdownStrict-Tests'
}

{ #category : #accessing }
MdsParagraphBlockTest >> parserClass [

	^ MarkdownStrictParser
]

{ #category : #tests }
MdsParagraphBlockTest >> testTwoSingleLinesWithSpaces [
	| root paragraph |
	
	root := parser parse: 'This is  
a paragraph on two lines, separated by two spaces'.
	self assert: root children size equals: 1.
	paragraph := root children first. 

	self assert: paragraph children first text equals: 'This is'.
	self assert: paragraph children second class equals: MdsLineBreakBlock.
	self assert: paragraph children third text equals: 'a paragraph on two lines, separated by two spaces'.
	self assert: paragraph text equals: 'This is
a paragraph on two lines, separated by two spaces'
]
