"
I'm a first version of a little UI to interactively select and see the results of running checkers.
"
Class {
	#name : 'MicCheckerDashboard',
	#superclass : 'SpPresenter',
	#instVars : [
		'checkerList',
		'explanation',
		'filePathInput',
		'runButton',
		'results',
		'browseButton',
		'currentFile',
		'fileContent',
		'checkerResults'
	],
	#category : 'Microdown-BookTester-UI',
	#package : 'Microdown-BookTester',
	#tag : 'UI'
}

{ #category : 'examples' }
MicCheckerDashboard class >> example [

	<script>
	self new open
]

{ #category : 'private' }
MicCheckerDashboard >> checkerBoxChanged: aCheckBox [
	"When aCheckBox gets ticked, show the explanation of its checker; French and English typography exclude each other, so ticking one unticks the other."

	| name checker exclusive |
	aCheckBox state ifFalse: [ ^ self ].
	name := aCheckBox label.
	checker := self checkerClasses detect: [ :c | c checkerName = name ] ifNone: [ ^ self ].
	explanation text: checker explanationForConfiguration.
	exclusive := {
		             ('FrenchTypography' -> 'EnglishTypography').
		             ('EnglishTypography' -> 'FrenchTypography') } asDictionary.
	exclusive
		at: name
		ifPresent: [ :other | checkerList presenters detect: [ :c | c label = other ] ifFound: [ :c | c state: false ] ]
]

{ #category : 'initialization' }
MicCheckerDashboard >> checkerClasses [

	^ MicChecker allSubclasses reject: [ :cls | cls isAbstract ] 

]

{ #category : 'accessing' }
MicCheckerDashboard >> checkerList [

	^ checkerList
]

{ #category : 'accessing' }
MicCheckerDashboard >> checkerResults [
	^ checkerResults
]

{ #category : 'accessing' }
MicCheckerDashboard >> checkerResults: aDict [
	checkerResults:= aDict 
]

{ #category : 'private' }
MicCheckerDashboard >> chooseFile [
	"Let the user pick the file to check with the file browser dialog and put its path in the path input."

	self fileDialog openModal ifNotNil: [ :entries | entries ifNotEmpty: [ filePathInput text: entries first fullName ] ]
]

{ #category : 'initialization' }
MicCheckerDashboard >> connectPresenters [

	checkerList presenters do: [ :cb | cb whenChangedDo: [ self checkerBoxChanged: cb ] ].
	runButton action: [ self runCheckers ].
	browseButton action: [ self chooseFile ]
]

{ #category : 'accessing' }
MicCheckerDashboard >> currentFile [

	^ currentFile
]

{ #category : 'layout' }
MicCheckerDashboard >> defaultLayout [

	| notebook topSection |
	notebook := self newNotebook.
	notebook addPage: (self newNotebookPage
			 title: 'Results';
			 presenterProvider: [ results ];
			 yourself).
	notebook addPage: (self newNotebookPage
			 title: 'File Content';
			 presenterProvider: [ fileContent ];
			 yourself).
	topSection := SpBoxLayout newTopToBottom
		              add: (SpPanedLayout newLeftToRight
				               positionOfSlider: 45 percent;
				               add: checkerList;
				               add: explanation;
				               yourself);
		              addLast: (SpBoxLayout newLeftToRight
				               add: filePathInput;
				               add: browseButton expand: false;
				               yourself)
		              expand: false;
		              addLast: (SpBoxLayout newLeftToRight
				               add: runButton;
				               yourself)
		              expand: false;
		              yourself.
	^ SpPanedLayout newTopToBottom
		  positionOfSlider: 55 percent;
		  add: topSection;
		  add: notebook;
		  yourself
]

{ #category : 'private' }
MicCheckerDashboard >> fileDialog [
	"Answer the file browser dialog used to pick the Microdown file to check, opened on the working directory and showing only Microdown files."

	^ StOpenFilePresenter new
		  openFolder: FileLocator workingDirectory asFileReference;
		  title: 'Select index.md';
		  extensions: #( 'md' ) named: 'Microdown files';
		  yourself
]

{ #category : 'initialization' }
MicCheckerDashboard >> initializePresenters [

	checkerList := self newComponentList.
	checkerList presenters: (MicChecker allSubclasses collect: [ :c |
				 | cb |
				 cb := self newCheckBox.
				 cb label: c checkerName.
				 cb ]).
	explanation := self newText.
	explanation text: 'Select a checker to see its explanation.'.
	filePathInput := self newTextInput.
	filePathInput placeholder: 'Path to index.md...'.
	results := self newText.
	results text: 'Results will appear here.'.
	results beNotEditable.
	fileContent := self newText.
	fileContent beNotEditable.
	runButton := self newButton.
	runButton label: 'Run Checkers'.
	browseButton := self newButton.
	browseButton label: 'Browse'
]

{ #category : 'initialization' }
MicCheckerDashboard >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Microdown Checker Dashboard';
	initialExtent: 900 @ 700.
]

{ #category : 'private' }
MicCheckerDashboard >> numberedContentOf: aFileReference [
	"Answer the contents of aFileReference with each line prefixed by its number."

	^ String streamContents: [ :s |
			  aFileReference contents lines doWithIndex: [ :line :i |
					  s print: i.
					  s nextPutAll: '  | '.
					  s nextPutAll: line.
					  s nextPut: Character lf ] ]
]

{ #category : 'reporting' }
MicCheckerDashboard >> reportFor: aCollectionOfResults [
	"Answer the text report of aCollectionOfResults: for each kind of result, its header followed by the explanation of each result of that kind."

	^ String streamContents: [ :stream |
			  (aCollectionOfResults groupedBy: [ :each | each class ]) valuesDo: [ :group |
					  stream
						  nextPutAll: '## ';
						  nextPutAll: group first headerString;
						  cr;
						  cr.
					  group do: [ :each |
							  stream
								  tab;
								  nextPutAll: each explanation;
								  cr ].
					  stream cr ] ]
]

{ #category : 'running' }
MicCheckerDashboard >> resultsOfCheckersNamed: aCollection on: aFileReference [
	"Run on aFileReference the checkers whose names are in aCollection and answer their results by checker name. A name that is no known checker is ignored."

	| resultsByName |
	resultsByName := Dictionary new.
	aCollection do: [ :name |
			self checkerClasses detect: [ :each | each checkerName = name ] ifFound: [ :checkerClass |
					| checker |
					checker := checkerClass new.
					checker rootDirectory: aFileReference parent.
					checker checkProject: aFileReference.
					resultsByName at: name put: checker results ] ].
	^ resultsByName
]

{ #category : 'accessing' }
MicCheckerDashboard >> runButton [

	^ runButton
]

{ #category : 'running' }
MicCheckerDashboard >> runCheckers [
	"Run the checkers ticked in the list on the file given in the path input, then show the report and the numbered content of the file."

	| selectedCheckers allResults |
	filePathInput text isEmpty ifTrue: [ ^ results text: 'Please enter a file path.' ].
	currentFile := filePathInput text asFileReference.
	currentFile exists ifFalse: [ ^ results text: 'File not found: ' , currentFile fullName ].
	selectedCheckers := checkerList presenters select: [ :cb | cb state ] thenCollect: [ :cb | cb label ].
	selectedCheckers isEmpty ifTrue: [ ^ results text: 'Please select at least one checker.' ].
	results text: 'Checking... please wait.'.
	checkerResults := self resultsOfCheckersNamed: selectedCheckers on: currentFile.
	allResults := checkerResults values flatCollect: [ :each | each ].
	allResults isEmpty ifTrue: [ ^ results text: 'No problems found!' ].
	results text: (self reportFor: allResults).
	fileContent text: (self numberedContentOf: currentFile)
]
