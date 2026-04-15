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
	file := fileSystem workingDirectory / 'level4DoublePeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label..'
		 ].
	file := fileSystem workingDirectory / 'level4PeriodSpacePeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label. .'
		 ].
]

{ #category : 'running' }
MicParagraphLabelCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicParagraphLabelChecker new.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testConfigureFromFalse [ 
	checker configureFrom: 'false'.
	self assert: checker labelShouldEndWithPeriod equals: false.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testConfigureFromNil [
	checker configureFrom: nil.
	self assert: checker labelShouldEndWithPeriod equals: true.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testConfigureFromTrue [ 
	checker configureFrom: 'true'.
	self assert: checker labelShouldEndWithPeriod equals: true.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testHeaderWithExtraPeriodRaisesError [
	| checker document |
	checker := MicParagraphLabelChecker new.
	checker levelForParagraph: 1.
	checker configureFrom: 'false'.
	document := Microdown parse: '# Titre avec une faute.'.
	
	checker visit: document children first.
	
	self assert: checker results size equals: 1.
	self assert: checker results first class name equals: 'MicParagraphLabelResult'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testHeaderWithFormattingAndPeriod [
    | checker document |
    checker := MicParagraphLabelChecker new.
    checker levelForParagraph: 4.
    checker configureFrom: 'false'. 
    document := Microdown parse: '##### Titre avec *italique* et point.'.
    
    checker visit: document children first.
    
    self assert: checker results size equals: 1.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testHeaderWithoutPeridoIsOkay [
	| checker document |
	checker := MicParagraphLabelChecker new.
	document := Microdown parse: '# Titre'.
	
	checker visit: document.
	self assert: checker results isEmpty.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testHeaderWithoutPeriodIsOkay [
	| checker document |
	checker := MicParagraphLabelChecker new.
	checker levelForParagraph: 1.
	checker configureFrom: 'false'.
	
	document := Microdown parse: '# Titre propre'.
	
	checker visit: document children first.
	
	self assert: checker results isEmpty.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel1NotChecked [
	checker checkProject: fileSystem / 'level1.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel2NotChecked [
	checker checkProject: fileSystem / 'level2.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel3NotChecked [
	checker checkProject: fileSystem / 'level3.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level4Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4CorrectNoExtraPeriod [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4Wrong.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4DoublePeriodDetected [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4DoublePeriod.md'.
	self deny: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4ExtraPeriodDetected [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4ExtraPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color.'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level4Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel4PeriodSpacePeriodDetected [
	checker identifyExtraPeriod.
	checker checkProject: fileSystem / 'level4PeriodSpacePeriod.md'.
	self deny: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel5Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level5Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel5MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level5Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel6Correct [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level6Correct.md'.
	self assert: checker isOkay.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevel6MissingPeriodDetected [
	checker identifyMissingPeriod.
	checker checkProject: fileSystem / 'level6Wrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape'.
]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testLevelConfiguration [
	| checker |
	checker := MicParagraphLabelChecker new.
	checker levelForParagraph: 5.
	self assert: checker levelForParagraph equals: 5.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testParagraphLevel4IsIgnoredWhenConfiguredForLevel5 [
    | checker document |
    checker := MicParagraphLabelChecker new.
    checker levelForParagraph: 5.
    checker configureFrom: 'false'. 
    document := Microdown parse: '#### Titre de niveau 4 avec point.'.
    
    checker visit: document children first.
    
    self assert: checker results isEmpty.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testParagraphLevel5IsChecked [
    | checker document |
    checker := MicParagraphLabelChecker new.
    checker levelForParagraph: 5.
    checker configureFrom: 'false'. 
    document := Microdown parse: '##### Titre de niveau 5 avec point.'.
    
    checker visit: document children first.
    
    self assert: checker results size equals: 1.

]

{ #category : 'tests' }
MicParagraphLabelCheckerTest >> testParagraphLevel6IsCheckedWhenConfiguredForLevel5 [
    | checker document |
    checker := MicParagraphLabelChecker new.
    checker levelForParagraph: 5.
    checker configureFrom: 'false'. 
    document := Microdown parse: '###### Titre de niveau 4 avec point.'.
    
    checker visit: document children first.
    
    self assert: checker results size equals: 1.

]
