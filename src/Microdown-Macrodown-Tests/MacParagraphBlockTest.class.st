Class {
	#name : #MacParagraphBlockTest,
	#superclass : #MicParagraphBlockTest,
	#category : #'Microdown-Macrodown-Tests'
}

{ #category : #accessing }
MacParagraphBlockTest >> parserClass [

	^ MacrodownParser
]

{ #category : #tests }
MacParagraphBlockTest >> testTwoSingleLinesWithSpaces [
	| root paragraph |
	
	root := parser parse: 'This is  
a paragraph on two lines, separated by two spaces'.
	self assert: root children size equals: 1.
	paragraph := root children first. 

	self assert: paragraph children first text equals: 'This is'.
	self assert: paragraph children second class equals: MacLineBreakBlock.
	self assert: paragraph children third text equals: 'a paragraph on two lines, separated by two spaces'.
	self assert: paragraph text equals: 'This is
a paragraph on two lines, separated by two spaces'
]
