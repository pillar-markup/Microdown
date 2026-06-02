Class {
	#name : 'MicFigureEmptyCaptionCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'checker'
	],
	#category : 'Microdown-BookTester-Checker-EmptyCaption',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-EmptyCaption'
}

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![](/fig.png)' ].
	
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile. 
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testCaptionIsOnlyPunctuationAndSpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![ , ; ](/fig.png)' ].
	
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![   	 ](/fig.png)' ].
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testCaptionIsValid [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![Une vraie légende](fig.png)' ].
	
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results isEmpty.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testCodeBlockCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'bogusCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '```smalltalk&caption=   '; cr.
		stream nextPutAll: '1 + 1'; cr.
		stream nextPutAll: '```' ].
	
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testConfigureFrom [

	| checker configuration |
	checker := MicEmptyCaptionChecker new.
	configuration := Dictionary new.

	configuration at: 'checkOnly' put: #('code' 'math').
	checker configureFrom: configuration.

	self assert: checker checkCode.
	self assert: checker checkMath.
	self deny: checker checkFigure
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testConfigureFromCheckOnly [
	| checker config |
	checker := MicEmptyCaptionChecker new.
	
	self assert: checker checkCode.
	self assert: checker checkFigure.
	self assert: checker checkMath.
	
	config := Dictionary new.
	config at: 'checkOnly' put: #('code' 'math').
	
	checker configureFrom: config.
	
	self assert: checker checkCode.
	self assert: checker checkMath.
	self deny: checker checkFigure.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testExplanationForConfiguration [

	| checker |
	checker := MicEmptyCaptionChecker new.
	
	self assert: checker explanationForConfiguration isString.
	self deny: checker explanationForConfiguration isEmpty
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testMathBlockCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'emptyCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '$$&caption='; cr.
		stream nextPutAll: 'V = \frac{4}{3}\pi r^3'; cr.
		stream nextPutAll: '$$' ].
	
	visitor := MicEmptyCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureEmptyCaptionCheckerTest >> testResultContainsMicElement [

	| block checker |
	checker := MicEmptyCaptionChecker new.
	block := MicFigureBlock new.
	checker checkCaptionOf: block.

	self assert: checker results size equals: 1.
	self assert: checker results first micElement equals: block
]
