"
Provides a presenter to display the currently selected CSS library details, such as:

- The main project web page.
- Themes list.
- Minified, Normalize and Reset versions.

"
Class {
	#name : #MicCSSStylerDetailViewsPresenter,
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
MicCSSStylerDetailViewsPresenter >> convertToHtml: micContents [
	"Answer a <String> formatted as HTML, applying receiver's setttings, from Microdown document in micContents"

	| micHtmlDoc |
	
	micHtmlDoc := MicHTMLDoc new.
	self styler hasCssSelection
		ifTrue: [ micHtmlDoc addCSSNamed: self cssFramework name ].
	^ micHtmlDoc
		fromMicrodown: micContents;
		contents
]

{ #category : #'accessing - pages' }
MicCSSStylerDetailViewsPresenter >> cssDetailsPage [

	^ (SpNotebookPage 
		title: 'CSS Details' 
		icon: (self iconNamed: #book) 
		provider: [ cssMetaInfoPresenter ])
		yourself

]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> cssFramework [

	^ self styler cssFramework
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> cssFramework: anObject [

	self styler cssFramework: anObject.
	self updatePresenter
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> cssListPresenter [

	^ self styler cssListPresenter
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> cssMetaInfoPresenter [

	^ cssMetaInfoPresenter
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> cssSourcePresenter [

	^ cssSourceCodePresenter

]

{ #category : #layout }
MicCSSStylerDetailViewsPresenter >> defaultLayout [ 

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
MicCSSStylerDetailViewsPresenter >> exportOptionsPage [

	^ (SpNotebookPage 
		title: 'Export Options' 
		icon: (self iconNamed: #smallExport) 
		provider: [ exportOptionsPresenter ])
		yourself
]

{ #category : #testing }
MicCSSStylerDetailViewsPresenter >> hasMicHtmlDocument [
	"Answer <true> if there is content in the HTML preview presenter"
	
	^ self htmlSourcePresenter text notEmpty
]

{ #category : #'accessing - pages' }
MicCSSStylerDetailViewsPresenter >> htmlOptionsPage [

	^ SpNotebookPage 
		title: 'HTML Options'
		icon: (self iconNamed: #configuration)
		provider: [ htmlOptionsPresenter ].
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> htmlSourcePresenter [

	^ htmlSourcePresenter

]

{ #category : #initialization }
MicCSSStylerDetailViewsPresenter >> initializeNotebookPresenter [

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
MicCSSStylerDetailViewsPresenter >> initializePresenters [ 

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

{ #category : #testing }
MicCSSStylerDetailViewsPresenter >> isOverwrite [

	^ exportOptionsPresenter isOverwrite
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> micDocument [

	^ self styler micHtmlDocument
]

{ #category : #updating }
MicCSSStylerDetailViewsPresenter >> micHtmlDocument [

	^ self styler micHtmlDocument
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> selectedCssFramework [

	^ self styler selectedCssFramework
]

{ #category : #accessing }
MicCSSStylerDetailViewsPresenter >> selectedCssFrameworkSourceCode [
	"Answer a <String> with the receiver's selected CSS Framework source code"

	^ self cssListPresenter selectedItem
		ifNotNil: [ : cssFrw | cssFrw sourceCode ]
		ifNil: [ String empty ]
]

{ #category : #'accessing - model' }
MicCSSStylerDetailViewsPresenter >> setModelBeforeInitialization: aDomainObject [

	styler := aDomainObject.
]

{ #category : #initialization }
MicCSSStylerDetailViewsPresenter >> styler [

	^ styler
]

{ #category : #updating }
MicCSSStylerDetailViewsPresenter >> updateHtmlOptionsPresenter [

	exportOptionsPresenter 
		outputDestinationPath: self micDocument destinationPath;
		outputFilename: self micDocument fileName.

]

{ #category : #updating }
MicCSSStylerDetailViewsPresenter >> updateHtmlSourcePresenter [

	self htmlSourcePresenter text: (self convertToHtml: self micDocument contents).

]

{ #category : #updating }
MicCSSStylerDetailViewsPresenter >> updatePresenter [

	super updatePresenter.
	self styler hasCssSelection ifFalse: [ ^ self ].
	self cssMetaInfoPresenter
		cssFramework: self selectedCssFramework;
		updatePresenter.
	self cssSourcePresenter text: self cssFramework sourceCode.

]
