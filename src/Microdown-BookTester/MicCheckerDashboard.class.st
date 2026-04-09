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
		'fileContent',
		'progressBar',
		'filterDropDown',
		'selectedCheckers'
	],
	#category : 'Microdown-BookTester-CheckerDashboard',
	#package : 'Microdown-BookTester',
	#tag : 'CheckerDashboard'
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
						(checker mutuallyExclusiveWith) do:
                     [ :excluded |
                        checkerList presenters
                            detect: [ :c | c label = excluded ]
                            ifFound: [ :c | c state: false ] ].
                     ] ] ] ].

    runButton action: [
	[ 
        | config output |
			progressBar show.
			runButton label: 'Checking...'.
			runButton enabled: false.
			exportButton enabled: false.
			currentReporter := nil.
			results text: ''.
        filePathInput text isEmpty
            ifTrue: [ 
				progressBar hide.
				runButton label: 'Run Checkers'.
				runButton enabled: true.
				results text: 'Please enter a file path.' ]
            ifFalse: [
                currentFile := filePathInput text asFileReference.
                currentFile exists
                    ifFalse: [ results text: 'File not found: ' , currentFile fullName ]
                    ifTrue: [
                        self selectedCheckers: ((checkerList presenters
                            select: [ :cb | cb state ])
                            collect: [ :cb | cb label ]).
                        self selectedCheckers isEmpty
                            ifTrue: [ 
									progressBar hide.
									runButton label: 'Run Checkers'.
									runButton enabled: true.
									results text: 'Please select at least one checker.' ]
                            ifFalse: [
                                results text: 'Checking... please wait.'.
                                config := ConfigurationForPillar newFromDictionary:
                                    {'onlyCheckers' -> self selectedCheckers } asDictionary.
                                currentReporter := MicAnalysisReportWriter
                                    reportForFolder: currentFile parent
                                    startingFrom: currentFile
                                    configuration: config.
                                currentReporter isOkay
                                    ifTrue: [ 
												progressBar hide.
												runButton label: 'Run Checkers'.
												runButton enabled: true.
												exportButton enabled: true.
												results text: self selectedCheckers asCommaString , ' - No problems found!' ]
                                    ifFalse: [
												| numberedContent lines |
                                        output := String streamContents: [ :str |
                                            currentReporter buildReportOn: str ].
                                        results text: output.
													self selectedCheckers do: [ :checkerName |
    												(currentReporter results noneSatisfy: [ :r | r class name includesSubstring: checkerName ])
        											ifTrue: [ results text: results text, String cr, checkerName, ' - No problems found!' ] ].
                                        exportButton enabled: true.
                                        
                                        lines := currentFile contents lines.
                                        numberedContent := String streamContents: [ :s |
                                            lines doWithIndex: [ :line :i |
                                                s nextPutAll: i printString.
                                                s nextPutAll: '  | '.
                                                s nextPutAll: line.
                                                s nextPut: Character lf ] ].
                                        fileContent text: numberedContent .
													runButton label: 'Run Checkers'.
													progressBar hide.
													runButton enabled: true.
													filterDropDown enabled: true.
													] ] ] ]
													] on: FileDoesNotExistException do: [ :ex |
													 progressBar hide.
													 results text: 'Error: File not found - ' , ex messageText ];
													 on: Error do: 	[ :ex |
														progressBar hide.
														results text: 'Error: ' , ex printString
														 ]
													]. 
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
		  htmlReporter selectedCheckers: self selectedCheckers.
        outputFile := htmlReporter generateReport.
        WebBrowser openOn: outputFile fullName.
        results text: results text , String cr , 'HTML report exported to: ' , outputFile fullName ]
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
            add: checkerList;            add: explanation;
            yourself);
        addLast: (SpBoxLayout newLeftToRight
            add: filePathInput;
            add: browseButton expand: false;
            yourself) expand: false;
        addLast: (SpBoxLayout newLeftToRight
            add: runButton;
            add: exportButton;
            yourself) expand: false;
		 addLast: progressBar expand: false;
        yourself.
    ^ SpPanedLayout newTopToBottom
        add: topSection;
        add: notebook;
 		  positionOfSlider: 400; 
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
	 progressBar := self newProgressBar.
	 progressBar indeterminate.
	 progressBar hide.
	 filterDropDown := self newDropList.
	 filterDropDown items: { 'All' } , (MicResult allSubclasses collect: #name).
	 filterDropDown selectIndex: 1.
	 filterDropDown enabled: false.
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

{ #category : 'accessing' }
MicCheckerDashboard >> selectedCheckers [

	^ selectedCheckers
]

{ #category : 'accessing' }
MicCheckerDashboard >> selectedCheckers: anObject [

	selectedCheckers := anObject
]
