Class {
	#name : #MicLinkBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitterClass'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #running }
MicLinkBlockTest >> setUp [

	super setUp.
	parser := self parser. 
	splitterClass := MicInlineParser
]

{ #category : #tests }
MicLinkBlockTest >> testPrintOn [

	| link |
	link := (splitterClass new parse: '[caption](aUrl)') first.
	self assert: link asString equals: '[caption](/aUrl)'
]
