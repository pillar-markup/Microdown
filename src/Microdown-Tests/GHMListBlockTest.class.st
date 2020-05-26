"
A GHMListBlockTest is a test class for testing the behavior of GHMListBlock
"
Class {
	#name : #GHMListBlockTest,
	#superclass : #GHMBlockTest,
	#instVars : [
		'root',
		'listBlock'
	],
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMListBlockTest >> setUp [
	super setUp.
	root := self rootBlockClass new.
	listBlock := self listBlockClass new parent: root.
	
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineDashForm [
	"indent from line return the position of the last character before the text."

	self
		assert:
			(listBlock
				indentFromLine: '- joe';
				indent)
		equals: 2.
	
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineNumberedForm [
	"indent from line return the position of the last character before the text."

	self
		assert:
			(listBlock
				indentFromLine: '10. joe';
				indent)
		equals: 4
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLinePlusForm [
	"indent from line return the position of the last character before the text."

	self
		assert:
			(listBlock
				indentFromLine: '+ joe';
				indent)
		equals: 2.
	
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineStarForm [
	"indent from line return the position of the last character before the text."

	self
		assert:
			(listBlock
				indentFromLine: '*  joe';
				indent)
		equals: 3.
	
]
