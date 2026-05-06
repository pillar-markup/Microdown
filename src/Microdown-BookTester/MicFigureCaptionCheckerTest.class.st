Class {
	#name : 'MicFigureCaptionCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'results'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![](/fig.png)' ].
	
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile. 
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testCaptionIsOnlyPunctuationAndSpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![ , ; ](/fig.png)' ].
	
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
	self assert: visitor results first class name equals: #MicMissingFigureCaptionResult.
]

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![   	 ](/fig.png)' ].
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testCaptionIsValid [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'test.md'.
	mdFile writeStreamDo: [ :stream | stream nextPutAll: '![Une vraie légende](fig.png)' ].
	
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results isEmpty.
]

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testCodeBlockCaptionIsOnlySpaces [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'bogusCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '```smalltalk&caption=   '; cr.
		stream nextPutAll: '1 + 1'; cr.
		stream nextPutAll: '```' ].
	
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]

{ #category : 'tests' }
MicFigureCaptionCheckerTest >> testMathBlockCaptionIsEmpty [
	| visitor mdFile mem |
	mem := FileSystem memory root.
	mdFile := mem / 'emptyCaption.md'.
	mdFile writeStreamDo: [ :stream | 
		stream nextPutAll: '$$&caption='; cr.
		stream nextPutAll: 'V = \frac{4}{3}\pi r^3'; cr.
		stream nextPutAll: '$$' ].
	
	visitor := MicFigureCaptionChecker new.
	visitor rootDirectory: mem.
	visitor checkProject: mdFile.
	
	self assert: visitor results size equals: 1.
]
