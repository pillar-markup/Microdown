"
Provides a presenter to display the currently selected CSS library details, such as:

- The main project web page.
- Themes list.
- Minified, Normalize and Reset versions.

"
Class {
	#name : #MicCSSStylerDetailsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'styler',
		'cssMetaInfoPresenter',
		'cssSourceCodePresenter',
		'notebookPresenter',
		'htmlSourcePresenter',
		'htmlOptionsPresenter',
		'exportOptionsPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> convertToHtml: micContents [
	"Answer a <String> formatted as HTML, applying receiver's setttings, from Microdown document in micContents"

	^ MicHTMLDoc new
		addCSSNamed: self cssFramework name;
		destinationPath: 'mic_html_examples';
		fromMicrodown: micContents;
		contents
]

{ #category : #'accessing - pages' }
MicCSSStylerDetailsPresenter >> cssDetailsPage [

	^ (SpNotebookPage 
		title: 'CSS Details' 
		icon: (self iconNamed: #book) 
		provider: [ cssMetaInfoPresenter ])
		yourself

]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework [

	^ self styler cssFramework
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework: anObject [

	self styler cssFramework: anObject.
	self updatePresenter
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssListPresenter [

	^ self styler cssListPresenter
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssMetaInfoPresenter [

	^ cssMetaInfoPresenter
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssSourcePresenter [

	^ cssSourceCodePresenter

]

{ #category : #layout }
MicCSSStylerDetailsPresenter >> defaultLayout [ 

	^ self layout: (SpPanedLayout newTopToBottom 
		positionOfSlider: 45 percent;
		add: notebookPresenter;
		add: (SpPanedLayout newLeftToRight 
			add: cssSourceCodePresenter;
			add: htmlSourcePresenter;
			yourself);
		yourself)
]

{ #category : #'accessing - pages' }
MicCSSStylerDetailsPresenter >> exportOptionsPage [

	^ (SpNotebookPage 
		title: 'Export Options' 
		icon: (self iconNamed: #smallExport) 
		provider: [ exportOptionsPresenter ])
		yourself
]

{ #category : #'accessing - pages' }
MicCSSStylerDetailsPresenter >> htmlOptionsPage [

	^ SpNotebookPage 
		title: 'HTML Options'
		icon: (self iconNamed: #configuration)
		provider: [ htmlOptionsPresenter ].
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> htmlSourcePresenter [

	^ htmlSourcePresenter

]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> initializeNotebookPresenter [

	cssMetaInfoPresenter := self instantiate: MicCSSStylerMetaInfoPresenter on: self cssFramework.
	htmlOptionsPresenter := self instantiate: MicCSSStylerHTMLOptionsPresenter.
	exportOptionsPresenter := self instantiate: MicCSSStylerExportOptionsPresenter.

	notebookPresenter := self newNotebook
		addPage: self htmlOptionsPage;
		addPage: self cssDetailsPage;
		addPage: self exportOptionsPage;
		yourself
]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> initializePresenters [ 

	htmlSourcePresenter := self newText
		beWrapWord;
		beNotEditable;
		yourself.
	cssSourceCodePresenter := self newText
		beWrapWord;
		beNotEditable;
		text: self selectedCssFrameworkSourceCode;
		yourself.
	self initializeNotebookPresenter.
]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> micDocumentFileRef [

	^ self styler micDocumentFileRef

]

{ #category : #updating }
MicCSSStylerDetailsPresenter >> micHtmlDocument [

	^ self styler micHtmlDocument
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> selectedCssFramework [

	^ self styler selectedCssFramework
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> selectedCssFrameworkSourceCode [
	"Answer a <String> with the receiver's selected CSS Framework source code"

	^ self cssListPresenter selectedItem
		ifNotNil: [ : cssFrw | cssFrw sourceCode ]
		ifNil: [ String empty ]
]

{ #category : #transmission }
MicCSSStylerDetailsPresenter >> setModel: aModel [

	self flag: #review.
	self htmlSourcePresenter text: aModel
]

{ #category : #'accessing - model' }
MicCSSStylerDetailsPresenter >> setModelBeforeInitialization: aDomainObject [

	styler := aDomainObject.
]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> styler [

	^ styler
]

{ #category : #updating }
MicCSSStylerDetailsPresenter >> updateHtmlSourcePresenter [

	| micContents |
	
	micContents := self micDocumentFileRef contents.	
	self htmlSourcePresenter text: (self convertToHtml: micContents).

]

{ #category : #updating }
MicCSSStylerDetailsPresenter >> updatePresenter [

	super updatePresenter.
	self styler hasCssSelection ifFalse: [ ^ self ].
	self cssMetaInfoPresenter
		cssFramework: self selectedCssFramework;
		updatePresenter.
	self cssSourcePresenter text: self selectedCssFrameworkSourceCode.
	self styler hasMicDocument
		ifFalse: [ ^ self ].
	exportOptionsPresenter
		outputFilename: self micHtmlDocument outputFilename;
		outputDestinationPath: self micHtmlDocument destinationPath.
]
