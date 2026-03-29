Class {
	#name : 'MicCheckerDashboard',
	#superclass : 'SpPresenter',
	#instVars : [
		'checkerList',
		'explanation',
		'filePathInput',
		'runButton',
		'results',
		'browseButton'
	],
	#category : 'Microdown-BookTester-CheckerDashboard',
	#package : 'Microdown-BookTester',
	#tag : 'CheckerDashboard'
}

{ #category : 'initialization' }
MicCheckerDashboard >> connectPresenters [ 
	checkerList presenters do: [ :cb |
		cb whenChangedDo: [
			| name checker |
			name := cb label.
			checker := MicChecker allSubclasses
				detect: [ :c | c checkerName = name ]
				ifNone: [ nil ].
			checker ifNotNil:[
				explanation text: checker explanationForConfiguration ].
				
				"Mutex"
				name = 'FrenchTypography' ifTrue: [ 
            (checkerList selectedItems includes: 'EnglishTypography') ifTrue: [
                checkerList unselectItem: 'EnglishTypography' ]].
        		name = 'EnglishTypography' ifTrue: [ 
            (checkerList selectedItems includes: 'FrenchTypography') ifTrue: [
                checkerList unselectItem: 'FrenchTypography' ]].
					 ] 
					 ].
	
	runButton action: [ 
		| config file reporter output selectedCheckers |
		
		filePathInput text isEmpty
			ifTrue: [ 
				results text: 'Please enter a file path.'.
			 ]
			ifFalse: [ 
				file := filePathInput text asFileReference.
				file exists ifFalse: [ 
					results text: 'File not found: ' , file fullName.
				]
			ifTrue: [ 	
				selectedCheckers := (checkerList presenters
				select: [ :cb | cb state ])
				collect: [ :cb | cb label ].
		selectedCheckers isEmpty ifTrue: [ 
			results text: 'Please select at least on checker.'.
			 ]
		ifFalse: [ 
		results text: 'Checking... please wait.'.
		config := ConfigurationForPillar newFromDictionary: 
			(Dictionary new
				at: 'onlyCheckers' put: selectedCheckers;
				yourself).
		reporter := MicAnalysisReportWriter 
			reportForFolder: file parent
			startingFrom: file 
			configuration: config.
		reporter isOkay 
			ifTrue: [ results text: 'No problems found!' ]
			ifFalse: [ 			
				output := String streamContents: [ :str | reporter buildReportOn: str].
				results text: output 
				]
	]]
	]
		 ].
	
	browseButton action: [
		| chosen |
		chosen := UIManager default
		chooseExistingFileReference:'Select index.md'
		 extensions: #('md')
		 path: FileSystem workingDirectory.
		chosen ifNotNil: [ filePathInput text: chosen fullName ] . ]
]

{ #category : 'initialization' }
MicCheckerDashboard >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom 
		add: (SpBoxLayout newLeftToRight
			add: checkerList;
			add: explanation;
			yourself);
		add: (SpBoxLayout newLeftToRight 
			add: filePathInput;
			add: browseButton expand: false;
			yourself) expand: false;
		add: runButton expand: false;
		add: results;
		
		yourself
]

{ #category : 'initialization' }
MicCheckerDashboard >> initializePresenters [ 
	checkerList := self newComponentList.
	checkerList presenters: (MicChecker allSubclasses collect: [:c | 
		| cb |
		cb := self newCheckBox.
		cb label: c checkerName.
		cb
		]).
	
	explanation := self newText.
	explanation text: 'Select a checker to see its explanation.'.
	
	filePathInput := self newTextInput.
	filePathInput placeholder: 'Path to index.md...'.
	
	results := self newText.
	results text: 'Results will appear here.'.
	results beNotEditable.
	
	runButton := self newButton.
	runButton label: 'Run Checkers'.

	browseButton := self newButton.
	browseButton label: 'Browse'.
]

{ #category : 'initialization' }
MicCheckerDashboard >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'Microdown Checker Dashboard';
	initialExtent: 900 @ 700.
]

{ #category : 'accessing' }
MicCheckerDashboard >> runButton [

	^ runButton
]
