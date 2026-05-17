Class {
	#name : 'MicFigureEmptyCaptionTest',
	#superclass : 'TestCase',
	#instVars : [
		'results'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![](/fig.png)' ].
	
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile. 
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testCaptionIsOnlyPunctuationAndSpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![ , ; ](/fig.png)' ].
	
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![   	 ](/fig.png)' ].
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testCaptionIsValid [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![Une vraie légende](fig.png)' ].
	
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results isEmpty.
]

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testCodeBlockCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'bogusCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '```smalltalk&caption=   '; cr.
		stream nextPutAll: '1 + 1'; cr.
		stream nextPutAll: '```' ].
	
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureEmptyCaptionTest >> testConfigureFromCheckOnly [
	| checker config |
	checker := MicFigureEmptyCaption new.
	
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
MicFigureEmptyCaptionTest >> testMathBlockCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'emptyCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '$$&caption='; cr.
		stream nextPutAll: 'V = \frac{4}{3}\pi r^3'; cr.
		stream nextPutAll: '$$' ].
	
	visitor := MicFigureEmptyCaption new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]
