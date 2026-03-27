Class {
	#name : 'MicReferencesCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-References',
	#package : 'Microdown-Rules',
	#tag : 'References'
}

{ #category : 'public - name' }
MicReferencesCheckerTest class >> checkerName [ 
	^ 'ReferenceChecks'
]

{ #category : 'running' }
MicReferencesCheckerTest >> generateFilesystemExample [
	| file |
	file := fileSystem  workingDirectory / 'figureWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'figure *@figbla@*'
		 ].
		file := fileSystem  workingDirectory / 'tableWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'table *@tablab@*'
		 ].
		file := fileSystem  workingDirectory / 'sectionWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'section *@secbla@*'
		 ].
		file := fileSystem  workingDirectory / 'theFigureWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'the figure *@figbla@*'
		 ].
			file := fileSystem  workingDirectory / 'theSectionWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'the section *@seclab@*'
		 ].
			file := fileSystem  workingDirectory / 'theTableWrong.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'the table *@tabbla@*'
		 ].
			file := fileSystem  workingDirectory / 'figureCorrect.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'Figure *@figbla@*'
		 ].
				file := fileSystem  workingDirectory / 'sectionCorrect.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'Section *@secbla@*'
		 ].
				file := fileSystem  workingDirectory / 'tableCorrect.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'Table *@tabbla@*'
		 ].
				file := fileSystem  workingDirectory / 'noAnchor.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: 'figure without anchor'
		 ].
]

{ #category : 'running' }
MicReferencesCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicAnchoredSectionTableFigureChecker new.
]

{ #category : 'running' }
MicReferencesCheckerTest >> testConfigureFromAnyValue [ 
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'running' }
MicReferencesCheckerTest >> testConfigureFromNil [
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'running' }
MicReferencesCheckerTest >> testFigureCorrect [
	checker checkProject: fileSystem / 'figureCorrect.md'.
	self assert: checker isOkay.
	
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testFigureExplanation [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self assert: checker results first explanation
	equals: 'Text: "figure " in file/figureWrong.md contains a mistake: [figure] should be capitalized as [Figure].'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testFigureLowercaseDetected [
	checker checkProject: fileSystem / 'figureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'figure'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testSectionCorrect [
	checker checkProject: fileSystem / 'sectionCorrect.md'.
	self assert: checker isOkay.
	
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testSectionLowercaseDetected [
	checker checkProject: fileSystem / 'sectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'section'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTableCorrect [
	checker checkProject: fileSystem / 'tableCorrect.md'.
	self assert: checker isOkay.
	
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTableLowercaseDetected [
	checker checkProject: fileSystem / 'tableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'table'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTextWithoutAnchor [
	checker checkProject: fileSystem / 'noAnchor.md'.
	self assert: checker isOkay.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTheFigureDetected [
	checker checkProject: fileSystem / 'theFigureWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the figure'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTheSectionDetected [
	checker checkProject: fileSystem / 'theSectionWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the section'.
	
]

{ #category : 'running' }
MicReferencesCheckerTest >> testTheTableDetected [
	checker checkProject: fileSystem / 'theTableWrong.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'the table'.
	
]
