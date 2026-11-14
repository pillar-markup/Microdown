"
I test `MicCheckerDashboard` without opening its window.

## Responsibility:

- Check that the dashboard can be created, so its presenters and their actions are wired.
- Check that it runs the checkers selected by name on a file and keeps their results per checker.
- Check the text report it shows: results grouped under the header of their kind, one explanation per line.

## Collaborators: 

- `MicCheckerDashboard` is the presenter under test.
- `MicHeaderCapitalizationChecker` (checker name `HeaderCapitalization`) produces the results, on files written in a memory `FileSystem`.

## Public API and Key Messages

- `fileWith:` writes a Microdown file in the memory file system and answers it.

```
MicCheckerDashboardTest suite run
```

"
Class {
	#name : 'MicCheckerDashboardTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'dashboard'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'helpers' }
MicCheckerDashboardTest >> fileWith: aString [
	"Write aString as the Microdown file index.md of the memory file system and answer that file."

	| file |
	file := fileSystem workingDirectory / 'index.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ].
	^ file
]

{ #category : 'running' }
MicCheckerDashboardTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	dashboard := MicCheckerDashboard new
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testDashboardIsCreatedWithItsRunButton [

	self assert: dashboard runButton label equals: 'Run Checkers'
]

{ #category : 'tests - file dialog' }
MicCheckerDashboardTest >> testFileDialogOpensOnWorkingDirectory [

	self assert: dashboard fileDialog fileNavigationSystem currentDirectory equals: FileLocator workingDirectory asFileReference
]

{ #category : 'tests - file dialog' }
MicCheckerDashboardTest >> testFileDialogShowsOnlyMicrodownFiles [

	| filter |
	filter := dashboard fileDialog fileNavigationSystem filtersDropList selectedItem.
	self assertCollection: filter extensions equals: #( 'md' ).
	self assert: filter basename equals: 'Microdown files'
]

{ #category : 'tests - file dialog' }
MicCheckerDashboardTest >> testFileDialogTitle [

	self assert: dashboard fileDialog title equals: 'Select index.md'
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testReportGroupsResultsUnderTheirHeader [

	| results |
	results := dashboard resultsOfCheckersNamed: #( 'HeaderCapitalization' ) on: (self fileWith: '# today

# tomorrow').
	self assert: (dashboard reportFor: (results at: 'HeaderCapitalization')) equals: (String streamContents: [ :stream |
				 stream
					 nextPutAll: '## First Element of Header is not Capitalized';
					 cr;
					 cr;
					 tab;
					 nextPutAll: 'Header: "today" in file/index.md contains a mistake: today as first word of the header should be uppercased.';
					 cr;
					 tab;
					 nextPutAll:
						 'Header: "tomorrow" in file/index.md contains a mistake: tomorrow as first word of the header should be uppercased.';
					 cr;
					 cr ])
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testResultsOfCheckerWithoutProblemAreEmpty [

	| results |
	results := dashboard resultsOfCheckersNamed: #( 'HeaderCapitalization' ) on: (self fileWith: '# Today and tomorrow').
	self assertEmpty: (results at: 'HeaderCapitalization')
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testResultsOfCheckersNamedOnFile [

	| results |
	results := dashboard resultsOfCheckersNamed: #( 'HeaderCapitalization' ) on: (self fileWith: '# today and tomorrow').
	self assert: results keys asArray equals: #( 'HeaderCapitalization' ).
	self assert: (results at: 'HeaderCapitalization') size equals: 1.
	self assert: (results at: 'HeaderCapitalization') first class equals: MicFirstElementOfHeaderIsNotCapitalizedResult
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testTickingEnglishTypographyUnticksFrenchTypography [

	| boxes french english |
	boxes := dashboard checkerList presenters.
	french := boxes detect: [ :each | each label = 'FrenchTypography' ].
	english := boxes detect: [ :each | each label = 'EnglishTypography' ].
	french state: true.
	english state: true.
	self assert: english state.
	self deny: french state
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testTickingFrenchTypographyUnticksEnglishTypography [

	| boxes french english |
	boxes := dashboard checkerList presenters.
	french := boxes detect: [ :each | each label = 'FrenchTypography' ].
	english := boxes detect: [ :each | each label = 'EnglishTypography' ].
	english state: true.
	french state: true.
	self assert: french state.
	self deny: english state
]

{ #category : 'tests' }
MicCheckerDashboardTest >> testUnknownCheckerNameIsIgnored [

	| results |
	results := dashboard resultsOfCheckersNamed: #( 'NoSuchChecker' ) on: (self fileWith: '# today').
	self assertEmpty: results
]
