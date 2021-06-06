Class {
	#name : #MicLinkBlockTest,
	#superclass : #MicElementTest,
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

{ #category : #tests }
MicLinkBlockTest >> testedClass [ 
	^ MicHorizontalLineBlock
]
