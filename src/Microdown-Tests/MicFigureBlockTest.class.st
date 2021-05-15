Class {
	#name : #MicFigureBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitterClass'
	],
	#category : #'Microdown-Tests'
}

{ #category : #running }
MicFigureBlockTest >> setUp [

	super setUp.
	parser := self parser.
	splitterClass := MicInlineSplitter 
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOn [
	| figure |
	figure := (splitterClass new start: '![caption](aUrl)') first.
	self assert: figure asString equals: '![caption](/aUrl)'
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOnWithParameters [
	| figure |
	figure := (splitterClass new start: '![caption](aUrl|label=1&title=testFigure)') first.
	self assert: figure asString equals: '![caption](/aUrl|title=testFigure&label=1 )'
]
