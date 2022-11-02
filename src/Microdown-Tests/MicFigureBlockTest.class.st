Class {
	#name : #MicFigureBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitterClass'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #running }
MicFigureBlockTest >> setUp [

	super setUp.
	parser := self parser.
	splitterClass := MicInlineParser2 
]

{ #category : #tests }
MicFigureBlockTest >> subjectClass [ 
	^ MicFigureBlock 
]

{ #category : #tests }
MicFigureBlockTest >> testAlt [

	| figure |
	figure := (splitterClass new parse:
		           '![caption with space and dot...](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true  width=80&alt=je suis le alt texte)')
		          first.

	self assert: figure arguments notEmpty.
	self assert: (figure arguments at: #alt) equals: 'je suis le alt texte'
]

{ #category : #tests }
MicFigureBlockTest >> testAnchor [

	| figure |
	figure := (splitterClass new parse:
		           '![caption with space and dot...](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true  width=80&anchor=233)')
		          first.

	self assert: figure hasArguments.
	self assert: figure hasAnchor.
	self assert: figure anchor equals: '233'
]

{ #category : #running }
MicFigureBlockTest >> testArgumentAtIfPresent [

	| expected tested |

	expected := MicFigureBlock new arguments at: 'testKey' put: 'nothing'.
	tested := self subject argumentAt: 'testKey' ifPresent: [ 'nothing' ].
	self assert: (tested isKindOf: MicFigureBlock).
	self assert: (tested arguments isKindOf: OrderedDictionary).
	self deny: (tested arguments includesKey: 'testKey').
	tested argumentAt: 'testKey' put: 'object'.
	self assert: (tested arguments includesKey: 'testKey').
	self assert: (tested arguments at: 'testKey') equals: 'object'.
]

{ #category : #tests }
MicFigureBlockTest >> testCaption [
	| figure |
	figure := (splitterClass new parse: '![caption with space and dot...](http://www.Pharo.ORG)') first.
	self assert: figure children first bodystring equals: 'caption with space and dot...'
	
	
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
MicFigureBlockTest >> testIsNotRelativeFilePathWithUrl [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.pharo.org)') first.
	self assert: figure reference fullName asString equals: 'http://www.pharo.org/'
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOn [
	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure asString equals: 'Figure{ Text(caption) }(http://www.Pharo.ORG)'
	
	"not really good but let us make it work"
]

{ #category : #tests }
MicFigureBlockTest >> testPrintOnWithParameters [
	| figure |
	figure := (splitterClass new parse: '![caption](http://anURL.org?label=1&title=testFigure)') first.
	self assert: figure asString equals: 'Figure{ Text(caption) }(http://anURL.org?label=1&title=testFigure)'
]

{ #category : #tests }
MicFigureBlockTest >> testUrlWitMicrodownParameterAndUrlParameters [

	| figure |
	figure := (splitterClass new parse:
		           '![caption](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true nolog=1&delog=1)')
		          first.
	self assert: figure reference fullName equals: 'https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true'. 
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
MicFigureBlockTest >> testUrlWithoutMicrodownParameters2 [

	| figure |
	figure := (splitterClass new parse: '![caption](http://www.Pharo.ORG)') first.
	self assert: figure reference fullName equals: 'http://www.pharo.org/'.

	figure := (splitterClass new parse: '![caption](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true)') first.
	self assert: figure reference fullName equals: 'https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true'.
	
]
