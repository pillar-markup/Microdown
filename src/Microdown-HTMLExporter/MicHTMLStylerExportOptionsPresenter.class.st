"
Provide a presenter with destination options for export such as:

- Output file name.
- Destination path.
- Overwrite existing files.


"
Class {
	#name : #MicHTMLStylerExportOptionsPresenter,
	#superclass : #MicHTMLStylerAbstractPresenter,
	#instVars : [
		'outputFilenameTextPresenter',
		'outputPathTextPresenter',
		'overwriteCheckboxPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicHTMLStylerExportOptionsPresenter >> defaultLayout [ 

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;		
			add: 'Output file name';
			add: outputFilenameTextPresenter;
			nextRow;
			add: 'Output folder';
			add: outputPathTextPresenter;
			nextRow;
			add: 'Overwrite';
			add: overwriteCheckboxPresenter ]
]

{ #category : #initialization }
MicHTMLStylerExportOptionsPresenter >> destinationPath [

	^ self styler hasMicDocumentFileRef
		ifTrue: [ self styler destinationPath ]
		ifFalse: [ String empty ]
]

{ #category : #initialization }
MicHTMLStylerExportOptionsPresenter >> initializePresenters [ 

	outputFilenameTextPresenter := self newTextInput
		help: 'Output file name';
		yourself.
	outputPathTextPresenter := self newTextInput 
		help: 'Select the output directory';
		text: self destinationPath;
		yourself.
	overwriteCheckboxPresenter := self newCheckBox
		state: true;
		yourself.
]

{ #category : #testing }
MicHTMLStylerExportOptionsPresenter >> isOverwrite [
	"Answer <true> if overwrite existing file is set"
	
	^ overwriteCheckboxPresenter state
]

{ #category : #accessing }
MicHTMLStylerExportOptionsPresenter >> micDocumentFileRef [

	^ self styler micDocumentFileRef
]

{ #category : #accessing }
MicHTMLStylerExportOptionsPresenter >> outputDestinationPath: aString [

	outputPathTextPresenter text: aString
]

{ #category : #accessing }
MicHTMLStylerExportOptionsPresenter >> outputFilename: aString [

	outputFilenameTextPresenter text: aString
]

{ #category : #private }
MicHTMLStylerExportOptionsPresenter >> selectDirectory [

	(UIManager default chooseDirectoryFrom: self destinationPath)
		ifNotNil: [ :selectedDirectory | self micHtmlDocument destinationPath: selectedDirectory ]
]
