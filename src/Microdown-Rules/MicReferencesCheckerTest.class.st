Class {
	#name : 'MicReferencesCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-AnchoredReferences',
	#package : 'Microdown-Rules',
	#tag : 'AnchoredReferences'
}

{ #category : 'public - name' }
MicReferencesCheckerTest class >> checkerName [ 
	^ 'ReferenceChecks'
]

{ #category : 'running' }
MicReferencesCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'figureWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'figure *@figbla@*' ].
	file := fileSystem workingDirectory / 'tableWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'table *@tablab@*' ].
	file := fileSystem workingDirectory / 'sectionWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'section *@secbla@*' ].
	file := fileSystem workingDirectory / 'theFigureWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'the figure *@figbla@*' ].
	file := fileSystem workingDirectory / 'theSectionWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'the section *@seclab@*' ].

	file := fileSystem workingDirectory / 'theTableWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'the table *@tabbla@*' ].

	file := fileSystem workingDirectory / 'theTableWrongNoTheButIn.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'in table *@tabbla@*' ].
	file := fileSystem workingDirectory / 'theTableWrongWithThe.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'The table *@tabbla@*' ].


	file := fileSystem workingDirectory / 'figureCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'See Figure *@figbla@*' ].
	file := fileSystem workingDirectory / 'sectionCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Section *@secbla@*' ].
	file := fileSystem workingDirectory / 'tableCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Table *@tabbla@*' ].


	file := fileSystem workingDirectory / 'noAnchor.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'figure without anchor' ].
	file := fileSystem workingDirectory / 'noAnchorUppercase.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'in Figure without anchor' ]

]

{ #category : 'running' }
MicReferencesCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicAnchoredSectionTableFigureChecker new.
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testConfigureFromAnyValue [ 
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testConfigureFromNil [
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests - correct' }
MicReferencesCheckerTest >> testFigureCorrect [

	checker checkProject: fileSystem / 'figureCorrect.md'.
	"See Figure @hkj@"
	
	self assert: checker isOkay
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testFigureExplanation [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self assert: checker results first explanation
	equals: 'Text: "figure " in file/figureWrong.md contains a mistake: [figure] should be capitalized as [Figure].'.
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testFigureLowercaseDetected [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'figure'.
	
]

{ #category : 'tests - correct' }
MicReferencesCheckerTest >> testSectionCorrect [

	checker checkProject: fileSystem / 'sectionCorrect.md'.
	"Section *@secbla@*"
	self assert: checker isOkay
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testSectionLowercaseDetected [
	checker checkProject: fileSystem / 'sectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'section'.
	
]

{ #category : 'tests - correct' }
MicReferencesCheckerTest >> testTableCorrect [
	checker checkProject: fileSystem / 'tableCorrect.md'.
	self assert: checker isOkay.
	
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTableLowercaseDetected [
	checker checkProject: fileSystem / 'tableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table'.
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTableLowercaseDetectedWithSomethingElseThanthe [

	self skip.
	self flag: #forAntoine.
	checker checkProject: fileSystem / 'theTableWrongNoTheButIn.md'.
	"'in table *@tabbla@*' is false because it should be in Table *@tabbla@*"
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table'.
	self
		assert: checker results first explanation
		equals:
		'Text: "in table " in file/theTableWrongNoTheButIn.md contains a mistake: [table] should be capitalized as [Table].'
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTableLowercaseDetectedWithThe [

	checker checkProject: fileSystem / 'theTableWrongWithThe.md'.
	" 'The table *@tabbla@*'
	This is not correct because we should have The in front so the explanation and probably the result is false.
	"
	self flag: #forAntoine.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'the table'.
	self
		assert: checker results first explanation
		equals:
		'Text: "The table " in file/theTableWrongWithThe.md contains a mistake: [the table] should be capitalized as [The table].'
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testTextWithoutAnchor [
	checker checkProject: fileSystem / 'noAnchor.md'.
	self assert: checker isOkay.
	
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testTextWithoutAnchorWithUppercase [

	self skip.
	checker checkProject: fileSystem / 'noAnchorUppercase.md'.
	"'in Figure without anchor reference' - here we are probably missing the reference
	"
	self flag: #ForAntoine.
	self deny: checker isOkay.
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheFigureDetected [
	checker checkProject: fileSystem / 'theFigureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the figure'.
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheSectionDetected [
	checker checkProject: fileSystem / 'theSectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the section'.
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheTableDetected [
	checker checkProject: fileSystem / 'theTableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the table'.
	
]
