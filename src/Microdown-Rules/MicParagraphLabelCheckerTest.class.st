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

	"#### Paragraph Label.. is bad and should be detected as faulty"
	
	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4DoublePeriods.md'.
	self deny: checker isOkay.
	self assert: checker results first explanation equals: '- Text: "Paragraph Label.." in file/level4DoublePeriods.md contains two periods.'

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
	"#### Paragraph Label. . is bad and should be detected as faulty"
	
	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4PeriodSpacePeriod.md'.
	self deny: checker isOkay.
	
	self assert: checker results first explanation equals: '- Text: "Paragraph Label. ." in file/level4PeriodSpacePeriod.md contains two periods.' 
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
