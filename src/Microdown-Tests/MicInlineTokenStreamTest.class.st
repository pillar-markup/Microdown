"
A MicInlineTokenStreamTest is a test class for testing the behavior of MicInlineTokenStream
"
Class {
	#name : #MicInlineTokenStreamTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-InlineParser'
}

{ #category : #tests }
MicInlineTokenStreamTest >> testTokenize [
	| tokens | 
	tokens := MicInlineTokenStream on: ''.
	self assert: tokens isEmpty
]

{ #category : #tests }
MicInlineTokenStreamTest >> testTokenize_justText [
	| tokens | 
	tokens := (MicInlineTokenStream on: 'aaaa') contents.
	self assert: tokens first substring equals: 'aaaa'.
	self assert: tokens first delimiter equals: nil.
]
