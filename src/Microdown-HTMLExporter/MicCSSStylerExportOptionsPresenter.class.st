Class {
	#name : #MicCSSStylerExportOptionsPresenter,
	#superclass : #MicCSSStylerAbstractPresenter,
	#instVars : [
		'outputFilenameTextPresenter',
		'outputPathTextPresenter',
		'overwriteCheckboxPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicCSSStylerExportOptionsPresenter >> defaultLayout [ 

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
MicCSSStylerExportOptionsPresenter >> destinationPath [

	^ self styler hasMicDocumentString
		ifTrue: [ self styler destinationPath ]
		ifFalse: [ String empty ]
]

{ #category : #initialization }
MicCSSStylerExportOptionsPresenter >> initializePresenters [ 

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
MicCSSStylerExportOptionsPresenter >> isOverwrite [
	"Answer <true> if overwrite existing file is set"
	
	^ overwriteCheckboxPresenter state
]

{ #category : #accessing }
MicCSSStylerExportOptionsPresenter >> micDocumentFileRef [

	^ self styler micDocumentFileRef
]

{ #category : #accessing }
MicCSSStylerExportOptionsPresenter >> outputDestinationPath: aString [

	outputPathTextPresenter text: aString
]

{ #category : #accessing }
MicCSSStylerExportOptionsPresenter >> outputFilename: aString [

	outputFilenameTextPresenter text: aString
]
