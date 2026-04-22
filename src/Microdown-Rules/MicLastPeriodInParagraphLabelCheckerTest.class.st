"
I am the test suite for MicParagraphLabelChecker.

I verify that:
- Labels at levels 4, 5 and 6 are correctly flagged when they do not end with a period (identifyMissingPeriod mode).
- Labels at levels 4, 5 and 6 are correctly flagged when they end with a period (identifyExtraPeriod mode).
- Labels at levels 1, 2 and 3 are never flagged regardless of the mode.
"
Class {
	#name : 'MicLastPeriodInParagraphLabelCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-LastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'LastPeriod'
}

{ #category : 'running' }
MicLastPeriodInParagraphLabelCheckerTest >> generateFilesystemExample [
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
	

	file := fileSystem workingDirectory / 'level1WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Title with period.' ].
	file := fileSystem workingDirectory / 'level1NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#Title without period' ].
	
		
	file := fileSystem workingDirectory / 'level2NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '## Title without period' ].
	file := fileSystem workingDirectory / 'level3NoPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '### Title with period' ].

	
	file := fileSystem workingDirectory / 'level2WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '## Title with period.' ].

	file := fileSystem workingDirectory / 'level3WithPeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '### Title with period.' ].

	
	file := fileSystem workingDirectory / 'level4DoublePeriods.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label..' ].
	
	file := fileSystem workingDirectory / 'level4PeriodSpacePeriod.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '#### Paragraph Label. .' ].
	
]

{ #category : 'running' }
MicLastPeriodInParagraphLabelCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicLastPeriodInParagraphLabelChecker new.
]

{ #category : 'tests - explanation' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigurationPart [

	self
		assert:
			(MicLastPeriodInParagraphLabelChecker configurationPartWithNewLine:
				 Character cr asString)
		equals: '{
	"LastPeriodInParagraphLabel" : {
		"isEndingWithPeriod" : true,
		"levelForPagraph" : 4
	}
}'
]

{ #category : 'tests - configure' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigureFromFalse [ 

	checker configureFrom: (Dictionary new 
		at: #isEndingWithPeriod put: false; 
		yourself).
	self deny: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigureFromNilUsesDefault [

	checker configureFrom: nil.
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigureFromTrue [

	checker configureFrom: (Dictionary new 
		at: #isEndingWithPeriod put: true; 
		yourself).
	self assert: checker isEndingWithPeriod
]

{ #category : 'tests - configure' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigureFromWithBogusLevelUsesDefaultValue [

	checker configureFrom: (Dictionary new
			 at: #levelForPar put: 3;
			 at: #isEndingWithPeriod put: true;
			 yourself).
	self assert: checker isEndingWithPeriod.
	self assert: checker levelForParagraph equals: checker defaultLevelForParagraph
]

{ #category : 'tests - configure' }
MicLastPeriodInParagraphLabelCheckerTest >> testConfigureFromWithLevel [

	checker configureFrom: (Dictionary new 
		at: #levelForParagraph put: 3;
		at: #isEndingWithPeriod put: true; 
		yourself).
	self assert: checker isEndingWithPeriod.
	self assert: checker levelForParagraph equals: 3
]

{ #category : 'tests - controlling levels' }
MicLastPeriodInParagraphLabelCheckerTest >> testHeaderWithFormattingAndPeriod [

	| document |
	checker levelForParagraph: 4.
	checker shouldNotEndWithPeriod.
	document := Microdown parse: '##### Title with  *italic* and period.'.

	checker visit: document children first.

	self assert: checker results size equals: 1.
]

{ #category : 'tests - section part' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel1ShouldNeverHavePeriod1 [
	"The configuration about ending or not with a period should not change the result 
	for level below the level"
	
	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level1NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level1WithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'- Paragraph: "Title with period." in file /level1WithPeriod.md contains a mistake: label should not be terminated with a period (.).'
]

{ #category : 'tests - section part' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel1ShouldNeverHavePeriod2 [
	"The configuration about ending or not with a period should not change the result 
	for level below the level"
	
	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level1NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level1WithPeriod.md'.
	self deny: checker isOkay.

	self
		assert: checker results first explanation
		equals:
		'- Paragraph: "Title with period." in file /level1WithPeriod.md contains a mistake: label should not be terminated with a period (.).'
]

{ #category : 'tests - section part' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel2ShouldNotHavePeriod [

	checker checkProject: fileSystem / 'level2NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level2WithPeriod.md'.
	self deny: checker isOkay.
]

{ #category : 'tests - section part' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel3ShouldNotHaveAPeriod [
	checker checkProject: fileSystem / 'level3NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level3WithPeriod.md'.
	self deny: checker isOkay.
	
	self 
		assert: checker results first explanation 
		equals: '- Paragraph: "Title with period." in file /level3WithPeriod.md contains a mistake: label should not be terminated with a period (.).'


]

{ #category : 'tests - two periods' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel4DoublePeriodDetected [
	"#### Paragraph Label.. is bad and should be detected as faulty"
	
	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4DoublePeriods.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation 
		equals: '- Text: "Paragraph Label.." in file/level4DoublePeriods.md contains two periods.'

]

{ #category : 'tests - should not end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel4NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level4NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level4WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color.'.
	self
		assert: checker results first explanation
		equals:
		'- Paragraph: "Color." in file /level4WithPeriod.md contains a mistake: label should not be terminated with a period (.).'
]

{ #category : 'tests - controlling levels' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel4ParagraphWithPeriodShouldBeFlagged [

	checker shouldEndWithPeriod.
	"but level 5 and 6 not 4"
	checker levelForParagraph: 5.
	checker checkProject: fileSystem / 'level4WithPeriod.md'.

	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self
		assert: checker results first explanation
		equals:
		'- Paragraph: "Color." in file /level4WithPeriod.md contains a mistake: label should not be terminated with a period (.).'
]

{ #category : 'tests - two periods' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel4PeriodSpacePeriodDetected [
	"#### Paragraph Label. . is bad and should be detected as faulty"
	
	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4PeriodSpacePeriod.md'.
	self deny: checker isOkay.
	
	self assert: checker results first explanation equals: '- Text: "Paragraph Label. ." in file/level4PeriodSpacePeriod.md contains two periods.' 
]

{ #category : 'tests - should end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel4ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level4WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level4NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Color'.
	self 
		assert: checker results first explanation 
		equals:  '- Paragraph: "Color" in file /level4NoPeriod.md contains a mistake: label should be terminated with a period (.).'
	
]

{ #category : 'tests - should not end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel5NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level5NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level5WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size.'.
]

{ #category : 'tests - should end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel5ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level5WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level5NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Size'.
	self 
		assert: checker results first explanation 
		equals: '- Paragraph: "Size" in file /level5NoPeriod.md contains a mistake: label should be terminated with a period (.).'
]

{ #category : 'tests - should not end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel6NoPeriod [

	checker shouldNotEndWithPeriod.
	checker checkProject: fileSystem / 'level6NoPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level6WithPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape.'.
]

{ #category : 'tests - should end with period' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevel6ShouldEndWithPeriod [

	checker shouldEndWithPeriod.
	checker checkProject: fileSystem / 'level6WithPeriod.md'.
	self assert: checker isOkay.

	checker checkProject: fileSystem / 'level6NoPeriod.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'Shape'.
]

{ #category : 'tests - controlling levels' }
MicLastPeriodInParagraphLabelCheckerTest >> testLevelForParagraph [

	checker levelForParagraph: 5.
	self assert: checker levelForParagraph equals: 5.

]

{ #category : 'tests - controlling levels' }
MicLastPeriodInParagraphLabelCheckerTest >> testParagraphLevel5IsChecked [

	checker shouldNotEndWithPeriod.
	checker levelForParagraph: 5.
	checker checkProject: fileSystem / 'level5NoPeriod.md'.

	self assert: checker isOkay
]

{ #category : 'tests - controlling levels' }
MicLastPeriodInParagraphLabelCheckerTest >> testParagraphWithExactLevelShouldBeFlagged [

	checker shouldEndWithPeriod.
	checker levelForParagraph: 5.
	checker checkProject: fileSystem / 'level5NoPeriod.md'.

	self deny: checker isOkay.
	self assert: checker results size equals: 1. 
	self 
		assert: checker results first explanation 
		equals:  '- Paragraph: "Size" in file /level5NoPeriod.md contains a mistake: label should be terminated with a period (.).'

]
