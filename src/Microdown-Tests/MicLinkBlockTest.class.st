Class {
	#name : #MicLinkBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitterClass'
	],
	#category : #'Microdown-Tests'
}

{ #category : #running }
MicLinkBlockTest >> setUp [

	super setUp.
	parser := self parser. 
	splitterClass := MicInlineSplitter
]

{ #category : #tests }
MicLinkBlockTest >> testPrintOn [
	| link |
	link := (splitterClass new start: '[caption](aUrl)') first.
	self assert: link asString equals: '[caption](/aUrl)'
]
