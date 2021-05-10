Class {
	#name : #MicLinkBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitter'
	],
	#category : #'Microdown-Tests'
}

{ #category : #running }
MicLinkBlockTest >> setUp [

	super setUp.
	parser := self parser. 
	splitter := MicInlineSplitter
]

{ #category : #tests }
MicLinkBlockTest >> testPrintOn [
	| figure |
	figure := (splitter new start: '[caption](aUrl)') first.
	self assert: figure asString equals: '[caption](/aUrl)'
]
