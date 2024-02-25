"
Provide a presenter with destination options for export such as:

- Output file name.
- Destination path.
- Overwrite existing files.


"
Class {
	#name : 'MicHTMLStylerExportOptionsPresenter',
	#superclass : 'MicHTMLStylerAbstractPresenter',
	#instVars : [
		'outputFilenameTextPresenter',
		'outputPathTextPresenter',
		'overwriteCheckboxPresenter',
		'browseOutputButton'
	],
	#category : 'Microdown-HTMLExporter-Spec',
	#package : 'Microdown-HTMLExporter',
	#tag : 'Spec'
}

{ #category : 'defaults' }
MicHTMLStylerExportOptionsPresenter >> defaultDestinationPath [ 

	^ 'mic_html_output'
]

{ #category : 'layout' }
MicHTMLStylerExportOptionsPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;
			rowSpacing: 15;
			add: 'Output file name';
			add: outputFilenameTextPresenter;
			nextRow;
			add: 'Output folder';
			add: outputPathTextPresenter;
			add: browseOutputButton;
			nextRow;
			add: 'Overwrite';
			add: overwriteCheckboxPresenter ]
]

{ #category : 'defaults' }
MicHTMLStylerExportOptionsPresenter >> defaultOutputFilename [

	^ 'index.html'
]

{ #category : 'initialization' }
MicHTMLStylerExportOptionsPresenter >> destinationPath [
	"Answer a <String> representing the path where the output files will be exported"

	^ outputPathTextPresenter text
		ifEmpty: [ self defaultDestinationPath ]
]

{ #category : 'initialization' }
MicHTMLStylerExportOptionsPresenter >> initializePresenters [ 

	outputFilenameTextPresenter := self newTextInput
		help: 'Output file name';
		text: self defaultOutputFilename;
		yourself.
	outputPathTextPresenter := self newTextInput 
		help: 'Select the output directory';
		text: self defaultDestinationPath;
		yourself.
	browseOutputButton := self newButton
		label: 'Select';
		icon: (self iconNamed: #smallOpen);
		action: [ self selectOutputDirectory ];
		yourself.
	overwriteCheckboxPresenter := self newCheckBox
		state: true;
		yourself.
]

{ #category : 'testing' }
MicHTMLStylerExportOptionsPresenter >> isOverwrite [
	"Answer <true> if overwrite existing file is set"
	
	^ overwriteCheckboxPresenter state
]

{ #category : 'accessing' }
MicHTMLStylerExportOptionsPresenter >> micDocumentFileRef [

	^ self styler micDocumentFileRef
]

{ #category : 'accessing' }
MicHTMLStylerExportOptionsPresenter >> outputDestinationPath: aString [

	outputPathTextPresenter text: aString
]

{ #category : 'accessing' }
MicHTMLStylerExportOptionsPresenter >> outputFilename: aString [

	outputFilenameTextPresenter text: aString
]

{ #category : 'initialization' }
MicHTMLStylerExportOptionsPresenter >> requestDirectoryForOpen [
	" Open request dialog to select a directory "
	
	^ UIManager default chooseDirectory: 'Choose a directory'
]

{ #category : 'initialization' }
MicHTMLStylerExportOptionsPresenter >> selectOutputDirectory [
	"Private - Callback for choose directory button"
	
	self requestDirectoryForOpen
		ifNotNil: [ : dirRef | 
			self styler hasMicHtmlDocument 
				ifTrue: [ self micHtmlDocument destinationPath: dirRef fullName ].
			outputPathTextPresenter text: dirRef fullName ].
]
