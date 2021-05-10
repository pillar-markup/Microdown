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
	| link |
	link := (splitter new start: '[caption](aUrl)') first.
	self assert: link asString equals: '[caption](/aUrl)'
]
