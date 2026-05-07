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

	"in the following the term figure should not be flagged
	there is not much that we can do"
	file := fileSystem workingDirectory / 'noAnchor.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'figure without anchor' ].
	
	"The following structure in Figure shows that the writer was inclined to refer to a figure."
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

	checker checkProject: fileSystem / 'theTableWrongNoTheButIn.md'.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table'.
	self
		assert: checker results first explanation
		equals: 'Text: "table *@tabbla@*" in file/theTableWrongNoTheButIn.md contains a mistake: [table *@tabbla@*] should be capitalized as [Table *@tabbla@*].'
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTableLowercaseDetectedWithThe [

	checker checkProject: fileSystem / 'theTableWrongWithThe.md'.
	"'The table *@tabbla@*' -> 'Table *@tabbla@*' "
	self flag: #Antoine.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'The table *@tabbla@*'.
	self
		assert: checker results first explanation
		equals: 'Text: "The table *@tabbla@*" in file/theTableWrongWithThe.md contains a mistake: [The table *@tabbla@*] should be capitalized as [Table *@tabbla@*].'
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testTextWithoutAnchor [
	"in the following the term figure should not be flagged
	there is not much that we can do"
	
	checker checkProject: fileSystem / 'noAnchor.md'.
	self assert: checker isOkay.
	
]

{ #category : 'tests - configure' }
MicReferencesCheckerTest >> testTextWithoutAnchorWithUppercase [

	checker checkProject: fileSystem / 'noAnchorUppercase.md'.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first explanation equals: 'Text: "in Figure without anchor" in file/noAnchorUppercase.md contains a mistake: [missing anchor for Figure] should be capitalized as [missing Figure].'.
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheFigureDetected [
		self flag: #Antoine.
	
	checker checkProject: fileSystem / 'theFigureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the figure'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the figure *@figbla@*" in file/theFigureWrong.md contains a mistake: [the figure *@figbla@*] should be capitalized as [Figure *@figbla@*].'
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheSectionDetected [
	self flag: #Antoine.
	
	checker checkProject: fileSystem / 'theSectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the section'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the section *@seclab@*" in file/theSectionWrong.md contains a mistake: [the section *@seclab@*] should be capitalized as [Section *@seclab@*].'
	
]

{ #category : 'tests - flagged violations' }
MicReferencesCheckerTest >> testTheTableDetected [
	self flag: #Antoine.
	checker checkProject: fileSystem / 'theTableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the table'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the table *@tabbla@*" in file/theTableWrong.md contains a mistake: [the table *@tabbla@*] should be capitalized as [Table *@tabbla@*].'
	
]
