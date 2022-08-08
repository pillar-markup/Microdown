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

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> cssSourceCodeForSelection [
	"Answer a <String> which is the source code matching the user selected options"

	^ self cssMetaInfoPresenter hasThemeSelection
		ifFalse: [
			self cssMetaInfoPresenter isMinifiedSelection
				ifFalse: [ self cssFramework sourceCode ]
				ifTrue: [ self cssFramework minifiedSourceCode ] ]
		ifTrue: [ 
			| currentTheme |
			currentTheme := self cssMetaInfoPresenter themeSelection.
			self cssMetaInfoPresenter isMinifiedSelection
				ifTrue: [ currentTheme  minifiedSourceCode ]
				ifFalse: [ currentTheme sourceCode ] ]
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssSourcePresenter [

	^ cssSourceCodePresenter

]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> cssTheme [

	^ self cssMetaInfoPresenter cssTheme
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
MicHTMLStylerDetailViewsPresenter >> destinationPath [
	
	^ exportOptionsPresenter destinationPath
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

{ #category : #testing }
MicHTMLStylerDetailViewsPresenter >> hasThemeSelection [
	
	^ self cssMetaInfoPresenter hasThemeSelection
]

{ #category : #'accessing - pages' }
MicHTMLStylerDetailViewsPresenter >> htmlOptionsPage [

	^ SpNotebookPage 
		title: 'HTML Options'
		icon: (self iconNamed: #configuration)
		provider: [ htmlOptionsPresenter ].
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> htmlOptionsPresenter [

	^ htmlOptionsPresenter
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> htmlOptionsPresenter: anObject [

	htmlOptionsPresenter := anObject
]

{ #category : #accessing }
MicHTMLStylerDetailViewsPresenter >> htmlSourcePresenter [

	^ htmlSourcePresenter

]

{ #category : #initialization }
MicHTMLStylerDetailViewsPresenter >> initializeNotebookPresenter [

	cssMetaInfoPresenter := self instantiate: MicHTMLStylerCSSInfoPresenter on: self styler.
	htmlOptionsPresenter := self instantiate: MicHTMLStylerHTMLOptionsPresenter on: self styler.
	exportOptionsPresenter := self instantiate: MicHTMLStylerExportOptionsPresenter on: self styler.

	notebookPresenter := self newNotebook
		addPage: self htmlOptionsPage;
		addPage: self cssDetailsPage;
		addPage: self exportOptionsPage;
		yourself
]

{ #category : #initialization }
MicHTMLStylerDetailViewsPresenter >> initializePresenters [ 

	htmlSourcePresenter := MicHTMLStylerHTMLSourcePresenter on: self.
	cssSourceCodePresenter := MicHTMLStylerCSSSourcePresenter on: self.
	self initializeNotebookPresenter.
]

{ #category : #testing }
MicHTMLStylerDetailViewsPresenter >> isOverwrite [

	^ exportOptionsPresenter isOverwrite
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

	exportOptionsPresenter outputFilename: self micHtmlDocument fileName.

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
	"Callback after CSS framework selection"

	super updatePresenter.
	self styler hasCssSelection ifFalse: [ ^ self ].
	self cssMetaInfoPresenter updatePresenter.
	self updateSourceCodePresenter.
	self htmlOptionsPresenter enableEmbeedCss.
]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> updatePresentersAfterThemeSelection [

	self styler hasMicDocumentFileRef ifFalse: [ ^ self ].
	self styler updateMicHtmlDocument.
	self updateHtmlSourcePresenter.

]

{ #category : #updating }
MicHTMLStylerDetailViewsPresenter >> updateSourceCodePresenter [

	self cssSourcePresenter text: self cssSourceCodeForSelection.

]
