Class {
	#name : 'MicParagrapheLabelCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'running' }
MicParagrapheLabelCheckerTest >> generateFilesystemExample [
	| file |
	"incorrect cases - no period"
	file := fileSystem workingDirectory / 'level4Wrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color'
		 ].
	file := fileSystem workingDirectory / 'level5Wrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '##### Size'
		 ].
	file := fileSystem workingDirectory / 'level6Wrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '###### Shape'
		 ].
	"incorrects cases - extra period"
	file := fileSystem workingDirectory / 'level4ExtraPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color.'
		 ].
	"correct cases with period"
	file := fileSystem workingDirectory / 'level4Correct.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color.'
		 ].	file := fileSystem workingDirectory / 'level5Correct.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '##### Size.'
		 ].
		file := fileSystem workingDirectory / 'level6Correct.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '###### Shape.'
		 ].
	"level 1 2 3 no verify"
		file := fileSystem workingDirectory / 'level1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#Title without period'
		 ].
		file := fileSystem workingDirectory / 'level2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '## Title without period'
		 ].
		file := fileSystem workingDirectory / 'level3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '### Title without period'
		 ].
]

{ #category : 'running' }
MicParagrapheLabelCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicParagraphLabelChecker new.
]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel1NotChecked [
	checker checkProject: fileSystem / 'level1.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel2NotChecked [
	checker checkProject: fileSystem / 'level2.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel3NotChecked [
	checker checkProject: fileSystem / 'level3.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel4Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level4Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel4CorrectNoExtraPeriod [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4Wrong.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel4ExtraPeriodDetected [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4ExtraPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color.'.
]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel4MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level4Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color'.
]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel5Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level5Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel5MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level5Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size'.
]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel6Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level6Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagrapheLabelCheckerTest >> testLevel6MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level6Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape'.
]
