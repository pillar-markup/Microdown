Class {
	#name : #MicFigureBlockTest,
	#superclass : #MicElementTest,
	#instVars : [
		'splitterClass'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #running }
MicFigureBlockTest >> setUp [

	super setUp.
	parser := self parser.
	splitterClass := MicInlineParser 
]

{ #category : #tests }
MicFigureBlockTest >> testCaption [
	| figure |
	figure := (splitterClass new parse: '![caption with space and dot...](http://www.Pharo.ORG)') first.
	self assert: figure caption equals: 'caption with space and dot...'
	
	
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOn [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure asString equals: '![caption](http://www.pharo.org/)'
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOnWithParameters [
	| figure |
	figure := (splitterClass new parse: '![caption](http://anURL.org?label=1&title=testFigure)') first.
	self assert: figure printString equals: '![caption](http://anurl.org/?title=testFigure&label=1)'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWithMicrodownParameters [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG?micAnchor=fig:pharo)') first.
	self assert: (figure query at: 'micAnchor') equals: 'fig:pharo'.
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWithoutMicrodownParameters [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure url printString equals: 'http://www.pharo.org/'.
	
	figure := (splitterClass new parse: '![caption](https://biblio.toutapprendre.com/newbiblio/index.aspx?nolog=1&delog=1)') first.
	self assert: (figure query at: 'nolog') equals: '1'.
	self assert: (figure query at: 'delog') equals: '1'.

]

{ #category : #tests }
MicFigureBlockTest >> testedClass [ 
	^ MicFigureBlock 
]
