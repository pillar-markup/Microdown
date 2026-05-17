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
		'exportButton',
		'reporter',
		'file',
		'currentFile',
		'currentReporter',
		'fileContent'
	],
	#category : 'Microdown-BookTester-UI',
	#package : 'Microdown-BookTester',
	#tag : 'UI'
}

{ #category : 'initialization' }
MicCheckerDashboard >> connectPresenters [
    checkerList presenters do: [ :cb |
        cb whenChangedDo: [
            cb state ifTrue: [
                | name checker |
                name := cb label.
                checker := MicChecker allSubclasses
                    detect: [ :c | c checkerName = name ]
                    ifNone: [ nil ].
                checker ifNotNil: [
                    explanation text: checker explanationForConfiguration.
                    name = 'FrenchTypography' ifTrue: [
                        checkerList presenters
                            detect: [ :c | c label = 'EnglishTypography' ]
                            ifFound: [ :c | c state: false ] ].
                    name = 'EnglishTypography' ifTrue: [
                        checkerList presenters
                            detect: [ :c | c label = 'FrenchTypography' ]
                            ifFound: [ :c | c state: false ] ] ] ] ] ].

    runButton action: [
        | config output selectedCheckers |
        filePathInput text isEmpty
            ifTrue: [ results text: 'Please enter a file path.' ]
            ifFalse: [
                currentFile := filePathInput text asFileReference.
                currentFile exists
                    ifFalse: [ results text: 'File not found: ' , currentFile fullName ]
                    ifTrue: [
                        selectedCheckers := (checkerList presenters
                            select: [ :cb | cb state ])
                            collect: [ :cb | cb label ].
                        selectedCheckers isEmpty
                            ifTrue: [ results text: 'Please select at least one checker.' ]
                            ifFalse: [
                                results text: 'Checking... please wait.'.
                                config := ConfigurationForPillar newFromDictionary:
                                    (Dictionary new
                                        at: 'onlyCheckers' put: selectedCheckers;
                                        yourself).
                                currentReporter := MicAnalysisReportWriter
                                    reportForFolder: currentFile parent
                                    startingFrom: currentFile
                                    configuration: config.
                                currentReporter isOkay
                                    ifTrue: [ results text: 'No problems found!' ]
                                    ifFalse: [
												| numberedContent lines |
                                        output := String streamContents: [ :str |
                                            currentReporter buildReportOn: str ].
                                        results text: output.
                                        exportButton enabled: true.
                                        
                                        lines := currentFile contents lines.
                                        numberedContent := String streamContents: [ :s |
                                            lines doWithIndex: [ :line :i |
                                                s nextPutAll: i printString.
                                                s nextPutAll: '  | '.
                                                s nextPutAll: line.
                                                s nextPut: Character lf ] ].
                                        fileContent text: numberedContent ] ] ] ] ].

    browseButton action: [
        | chosen |
        chosen := UIManager default
            chooseExistingFileReference: 'Select index.md'
            extensions: #('md')
            path: FileSystem workingDirectory.
        chosen ifNotNil: [ filePathInput text: chosen fullName ] ].

    exportButton action: [
        | htmlReporter outputFile |
        htmlReporter := MicCheckerHTMLReporter new.
        htmlReporter reporter: currentReporter.
        htmlReporter fileReference: currentFile.
        outputFile := htmlReporter generateReport.
        WebBrowser openOn: outputFile fullName.
        results text: results text , String cr , 'HTML report exported to: ' , outputFile fullName ].
]

{ #category : 'initialization' }
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
            add: checkerList;
            add: explanation;
            yourself);
        addLast: (SpBoxLayout newLeftToRight
            add: filePathInput;
            add: browseButton expand: false;
            yourself) expand: false;
        addLast: (SpBoxLayout newLeftToRight
            add: runButton;
            add: exportButton;
            yourself) expand: false;
        yourself.
    ^ SpPanedLayout newTopToBottom
        add: topSection;
        add: notebook;
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
    exportButton := self newButton.
    exportButton label: 'Export HTML Report'.
    exportButton enabled: false.
    browseButton := self newButton.
    browseButton label: 'Browse'.
]

{ #category : 'initialization' }
MicCheckerDashboard >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Microdown Checker Dashboard';
	initialExtent: 900 @ 700.
]

{ #category : 'accessing' }
MicCheckerDashboard >> runButton [

	^ runButton
]
