Class {
	#name : 'MicAnchoredSectionTableFigureCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker',
		'inFile'
	],
	#category : 'Microdown-BookTester-Checker-BookTester',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-BookTester'
}

{ #category : 'running' }
MicAnchoredSectionTableFigureCheckerTest >> generateFilesystemExample [

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
MicAnchoredSectionTableFigureCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicAnchoredSectionTableFigureChecker new.
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testConfigurationPart [

	self 
		assert:
		(MicAnchoredSectionTableFigureChecker configurationPartWithNewLine: (Character cr asString)) 
		equals:  '{
	"NotTheFigureX" : {
		"extraAnchoredElements" : [
			"note"
		]
	}
}'
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testConfigureFrom [
	| config |
	config := Dictionary new.
	config 
		at: 'extraAnchoredElements' 
		put: #('note' 'anecdote').

	checker configureFrom: config.
	
	self assert: (checker anchoredElements includes: 'note').
	self assert: (checker anchoredElements includes: 'anecdote')
]

{ #category : 'tests - configure' }
MicAnchoredSectionTableFigureCheckerTest >> testConfigureFromAnyValue [

	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests - configure' }
MicAnchoredSectionTableFigureCheckerTest >> testConfigureFromNil [

	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests - correct' }
MicAnchoredSectionTableFigureCheckerTest >> testFigureCorrect [

	checker checkProject: fileSystem / 'figureCorrect.md'.
	"See Figure @hkj@"
	
	self assert: checker isOkay
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testFigureExplanation [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self assert: checker results first explanation 
	equals: 'Text: "figure " in file /figureWrong.md contains a mistake: [figure *@figbla@*] should be capitalized as [figure *@figbla@*].'
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testFigureLowercaseDetected [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'figure *@figbla@*'.
	
]

{ #category : 'tests - correct' }
MicAnchoredSectionTableFigureCheckerTest >> testSectionCorrect [

	checker checkProject: fileSystem / 'sectionCorrect.md'.
	"Section *@secbla@*"
	self assert: checker isOkay
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testSectionLowercaseDetected [
	checker checkProject: fileSystem / 'sectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'section *@secbla@*'.
	
]

{ #category : 'tests - correct' }
MicAnchoredSectionTableFigureCheckerTest >> testTableCorrect [
	checker checkProject: fileSystem / 'tableCorrect.md'.
	self assert: checker isOkay.
	
	
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTableLowercaseDetected [
	checker checkProject: fileSystem / 'tableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table *@tablab@*'.
	
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTableLowercaseDetectedWithSomethingElseThanthe [
	checker checkProject: fileSystem / 'theTableWrongNoTheButIn.md'.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table *@tabbla@*'.
	self
		assert: checker results first explanation 
		equals: 'Text: "in table " in file /theTableWrongNoTheButIn.md contains a mistake: [table *@tabbla@*] should be capitalized as [table *@tabbla@*].'
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTableLowercaseDetectedWithThe [
	checker checkProject: fileSystem / 'theTableWrongWithThe.md'.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'The table *@tabbla@*'.
	self
		assert: checker results first explanation 
		equals: 'Text: "The table " in file /theTableWrongWithThe.md contains a mistake: [The table *@tabbla@*] should be capitalized as [The *@tabbla@*].'
]

{ #category : 'tests - configure' }
MicAnchoredSectionTableFigureCheckerTest >> testTextWithoutAnchor [
	"in the following the term figure should not be flagged
	there is not much that we can do"
	
	checker checkProject: fileSystem / 'noAnchor.md'.
	self assert: checker isOkay.
	
]

{ #category : 'tests - configure' }
MicAnchoredSectionTableFigureCheckerTest >> testTextWithoutAnchorWithUppercase [

	checker checkProject: fileSystem / 'noAnchorUppercase.md'.
	
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first explanation equals: 'Text: "in Figure without anchor" in file /noAnchorUppercase.md contains a mistake: [missing anchor for Figure] should be capitalized as [missing Figure].'.
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTheFigureDetected [
	
	checker checkProject: fileSystem / 'theFigureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the figure *@figbla@*'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the figure " in file /theFigureWrong.md contains a mistake: [the figure *@figbla@*] should be capitalized as [the *@figbla@*].'
	
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTheSectionDetected [
	checker checkProject: fileSystem / 'theSectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the section *@seclab@*'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the section " in file /theSectionWrong.md contains a mistake: [the section *@seclab@*] should be capitalized as [the *@seclab@*].'
	
]

{ #category : 'tests - flagged violations' }
MicAnchoredSectionTableFigureCheckerTest >> testTheTableDetected [
	checker checkProject: fileSystem / 'theTableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the table *@tabbla@*'.
	
	self
		assert: checker results first explanation 
		equals: 'Text: "the table " in file /theTableWrong.md contains a mistake: [the table *@tabbla@*] should be capitalized as [the *@tabbla@*].'
	
]
