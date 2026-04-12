"
I am the test suite for MicParagraphLabelChecker.

I verify that:
- Labels at levels 4, 5 and 6 are correctly flagged when they do not end with a period (identifyMissingPeriod mode).
- Labels at levels 4, 5 and 6 are correctly flagged when they end with a period (identifyExtraPeriod mode).
- Labels at levels 1, 2 and 3 are never flagged regardless of the mode.
"
Class {
	#name : 'MicParagraphLabelCheckerTest',
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
MicParagraphLabelCheckerTest >> generateFilesystemExample [
	| file |
	
	"incorrect cases - no period"
	file := fileSystem workingDirectory / 'level4NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color' ].
	
	file := fileSystem workingDirectory / 'level5NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '##### Size' ].
	
	file := fileSystem workingDirectory / 'level6NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '###### Shape' ].
	
	file := fileSystem workingDirectory / 'level4WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color.' ].
	
	file := fileSystem workingDirectory / 'level4WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Color.' ].
	
	file := fileSystem workingDirectory / 'level5WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '##### Size.'].
		file := fileSystem workingDirectory / 'level6WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '###### Shape.' ].
	





	file := fileSystem workingDirectory / 'level1NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#Title without period' ].
		
	file := fileSystem workingDirectory / 'level2NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '## Title without period' ].
	file := fileSystem workingDirectory / 'level3NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '### Title without period' ].

	file := fileSystem workingDirectory / 'level1WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#Title without period.' ].
	file := fileSystem workingDirectory / 'level2WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '## Title without period.' ].

	file := fileSystem workingDirectory / 'level3WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '### Title without period.' ].

	
	file := fileSystem workingDirectory / 'level4DoublePeriods.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label..' ].
	
	file := fileSystem workingDirectory / 'level4PeriodSpacePeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label. .' ].
	
]

{ #category : 'running' }
MicParagraphLabelCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicParagraphLabelChecker new.
]

{ #category : 'tests - configure' }
MicParagraphLabelCheckerTest >> testConfigureFromFalse [ 
	checker configureFrom: 'false'.
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicParagraphLabelCheckerTest >> testConfigureFromNil [

	checker configureFrom: nil.
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicParagraphLabelCheckerTest >> testConfigureFromTrue [ 
	checker configureFrom: 'true'.
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests - section part' }
MicParagraphLabelCheckerTest >> testLevel1 [
	checker checkProject: fileSystem / 'level1NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level1WithPeriod.md'.
	self deny: checker isOkay.

]

{ #category : 'tests - section part' }
MicParagraphLabelCheckerTest >> testLevel2 [
	checker checkProject: fileSystem / 'level2NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level2WithPeriod.md'.
	self deny: checker isOkay.
]

{ #category : 'tests - section part' }
MicParagraphLabelCheckerTest >> testLevel3 [
	checker checkProject: fileSystem / 'level3NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level3WithPeriod.md'.
	self deny: checker isOkay.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4DoublePeriodDetected [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4DoublePeriods.md'.
	self deny: checker isOkay.

]

{ #category : 'tests - should not end with period' }
MicParagraphLabelCheckerTest >> testLevel4NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level4NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level4WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color.'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4PeriodSpacePeriodDetected [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4PeriodSpacePeriod.md'.
	self deny: checker isOkay.

]

{ #category : 'tests - should end with period' }
MicParagraphLabelCheckerTest >> testLevel4ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level4NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color'.
]

{ #category : 'tests - should not end with period' }
MicParagraphLabelCheckerTest >> testLevel5NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level5NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level5WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size.'.
]

{ #category : 'tests - should end with period' }
MicParagraphLabelCheckerTest >> testLevel5ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level5WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level5NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size'.
]

{ #category : 'tests - should not end with period' }
MicParagraphLabelCheckerTest >> testLevel6NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level6NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level6WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape.'.
]

{ #category : 'tests - should end with period' }
MicParagraphLabelCheckerTest >> testLevel6ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level6WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level6NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape'.
]
