"
Provides a presenter to display the currently selected CSS library details, such as:

- The main project web page.
- Themes list.
- Minified, Normalize and Reset versions.

"
Class {
	#name : #MicHTMLStylerDetailViewsPresenter,
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

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> charSet [

	^ htmlOptionsPresenter charSet.
]

{ #category : #'accessing - pages' }
MicHTMLStylerDetailViewsPresenter >> cssDetailsPage [

	^ (SpNotebookPage 
		title: 'CSS Details' 
		icon: (self iconNamed: #book) 
		provider: [ cssMetaInfoPresenter ])
		yourself

]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssFramework [

	^ self styler cssFramework
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssFramework: anObject [

	self styler cssFramework: anObject.
	self updatePresenter
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssListPresenter [

	^ self styler cssListPresenter
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssMetaInfoPresenter [

	^ cssMetaInfoPresenter
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssSourcePresenter [

	^ cssSourceCodePresenter

]

{ #category : #layout }
MicHTMLStylerDetailViewsPresenter >> defaultLayout [ 

	^ self layout: (SpPanedLayout newTopToBottom 
		positionOfSlider: 45 percent;
		add: notebookPresenter;
		add: (SpPanedLayout newLeftToRight 
			add: cssSourceCodePresenter;
			add: htmlSourcePresenter;
			yourself);
		yourself)
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> documentType [
	"Answer a <String> describing the selected HTML document type"

	^ htmlOptionsPresenter documentType.
]

{ #category : #'accessing - pages' }
MicHTMLStylerDetailViewsPresenter >> exportOptionsPage [

	^ (SpNotebookPage 
		title: 'Export Options' 
		icon: (self iconNamed: #smallExport) 
		provider: [ exportOptionsPresenter ])
		yourself
]

{ #category : #testing }
MicHTMLStylerDetailViewsPresenter >> hasMicHtmlDocument [
	"Answer <true> if there is content in the HTML preview presenter"
	
	^ self htmlSourcePresenter text notEmpty
]

{ #category : #'accessing - pages' }
MicHTMLStylerDetailViewsPresenter >> htmlOptionsPage [

	^ SpNotebookPage 
		title: 'HTML Options'
		icon: (self iconNamed: #configuration)
		provider: [ htmlOptionsPresenter ].
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> htmlSourcePresenter [

	^ htmlSourcePresenter

]

{ #category : #initialization }
MicHTMLStylerDetailViewsPresenter >> initializeNotebookPresenter [

	cssMetaInfoPresenter := self instantiate: MicHTMLStylerCSSInfoPresenter on: self cssFramework.
	htmlOptionsPresenter := self instantiate: MicHTMLStylerOptionsPresenter on: self styler.
	exportOptionsPresenter := self instantiate: MicHTMLStylerExportOptionsPresenter on: self styler.

	notebookPresenter := self newNotebook
		addPage: self htmlOptionsPage;
		addPage: self cssDetailsPage;
		addPage: self exportOptionsPage;
		yourself
]

{ #category : #initialization }
MicHTMLStylerDetailViewsPresenter >> initializePresenters [ 

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
MicHTMLStylerDetailViewsPresenter >> isOverwrite [

	^ exportOptionsPresenter isOverwrite
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> micDocument [

	^ self styler micHtmlDocument
]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> micDocumentString [

	^ self styler micDocumentString

]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> micHtmlDocument [

	^ self styler micHtmlDocument
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> selectedCssFramework [

	^ self styler selectedCssFramework
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> selectedCssFrameworkSourceCode [
	"Answer a <String> with the receiver's selected CSS Framework source code"

	^ self cssListPresenter selectedItem
		ifNotNil: [ : cssFrw | cssFrw sourceCode ]
		ifNil: [ String empty ]
]

{ #category : #'accessing - model' }
MicHTMLStylerDetailViewsPresenter >> setModelBeforeInitialization: aDomainObject [

	styler := aDomainObject.
]

{ #category : #initialization }
MicHTMLStylerDetailViewsPresenter >> styler [

	^ styler
]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> updateHtmlOptionsPresenter [

	exportOptionsPresenter 
		outputDestinationPath: self micDocument destinationPath;
		outputFilename: self micDocument fileName.

]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> updateHtmlSourcePresenter [
	"Update the receiver's HTML view"

	| updatedMicHtml |
	
	updatedMicHtml := self micHtmlDocument fromMicrodown: self micDocumentString.
	self htmlSourcePresenter text: updatedMicHtml contents
]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> updatePresenter [

	super updatePresenter.
	self styler hasCssSelection ifFalse: [ ^ self ].
	self cssMetaInfoPresenter
		cssFramework: self selectedCssFramework;
		updatePresenter.
	self cssSourcePresenter text: self cssFramework sourceCode.

]
