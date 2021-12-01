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
MicFigureBlockTest >> testHasArguments [
	| figure |
	figure := (splitterClass new parse: '![caption with space and dot...](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true  width=80&anchor=bla)') first.
	
	"Indeed url arguments are not microdown arguments"
	self assert: figure hasArguments.
	self assert: (figure arguments at: 'width') equals: '80'.
	self assert: (figure arguments at: 'anchor') equals: 'bla'
	
	
]

{ #category : #tests }
MicFigureBlockTest >> testHasNoArguments [
	| figure |
	figure := (splitterClass new parse: '![caption with space and dot...](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true)') first.
	
	"Indeed url arguments are not microdown arguments"
	self deny: figure hasArguments
	
	
]

{ #category : #'tests - testing' }
MicFigureBlockTest >> testIsNotRelativeFilePath [
	| figure |
	figure := (splitterClass new parse: '![caption](file:///Users/name/figures/test.mic)') first.
	self assert: figure reference isResolved
]

{ #category : #'tests - testing' }
MicFigureBlockTest >> testIsNotRelativeFilePathWithUrl [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.pharo.org)') first.
	self assert: figure reference uri asString equals: 'http://www.pharo.org/'
]

{ #category : #'tests - testing' }
MicFigureBlockTest >> testIsNotValidImage [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](file://figures/test.mic)') first.
	self assert: figure reference isImage not
]

{ #category : #'tests - testing' }
MicFigureBlockTest >> testIsValidImage [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](file:///figures/test.png)') first.
	self assert: figure reference isImage
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOn [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure asString equals: '![caption](http://www.Pharo.ORG)'
	
	"not really good but let us make it work"
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOnWithParameters [
	| figure |
	figure := (splitterClass new parse: '![caption](http://anURL.org?label=1&title=testFigure)') first.
	self assert: figure printString equals: '![caption](http://anURL.org?label=1&title=testFigure)'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWitMicrodownParameterAndUrlParameters [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true nolog=1&delog=1)')
		          first.
	self assert: figure reference uri asString equals: 'https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true'. 
	self assert: (figure arguments at: 'nolog') equals: '1'.
	self assert: (figure arguments at: 'delog') equals: '1'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWithMicrodownParameters [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](http://www.Pharo.ORG anchor=fig:pharo)')
		          first.
	self assert: (figure arguments at: 'anchor') equals: 'fig:pharo'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWithoutMicrodownParameters [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](http://www.Pharo.orG)') first.
	self assert: figure reference uri asString equals: 'http://www.pharo.org/'.

	figure := (splitterClass new parse:
		           '![caption](https://biblio.toutapprendre.com/newbiblio/index.aspx nolog=1&delog=1)')
		          first.
	self assert: figure reference uri asString equals: 'https://biblio.toutapprendre.com/newbiblio/index.aspx'.
	self assert: (figure arguments at: 'nolog') equals: '1'.
	self assert: (figure arguments at: 'delog') equals: '1'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWithoutMicrodownParameters2 [

	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure reference uri asString equals: 'http://www.pharo.org/'.

	figure := (splitterClass new parse: '![caption](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true)') first.
	self assert: figure reference uri asString equals: 'https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true'.
	
]

{ #category : #tests }
MicFigureBlockTest >> testedClass [ 
	^ MicFigureBlock 
]
