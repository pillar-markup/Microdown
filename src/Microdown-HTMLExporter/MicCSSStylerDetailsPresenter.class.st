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
		'cssMetaInfoPresenter',
		'cssSourceCodePresenter',
		'cssFramework',
		'notebookPresenter',
		'htmlSourcePresenter',
		'htmlOptionsPresenter'
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

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> cssDetailsPage [

	^ (SpNotebookPage 
		title: 'CSS Details' 
		icon: (self iconNamed: #book) 
		provider: [ cssMetaInfoPresenter ])
		yourself

]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework [

	^ cssFramework
]

{ #category : #accessing }
MicCSSStylerDetailsPresenter >> cssFramework: anObject [

	cssFramework := anObject.
	self updatePresenter
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

{ #category : #initialization }
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

	notebookPresenter := self newNotebook
		addPage: self htmlOptionsPage;
		addPage: self cssDetailsPage;
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
		text: self cssFramework sourceCode;
		yourself.
	self initializeNotebookPresenter.
]

{ #category : #'accessing - model' }
MicCSSStylerDetailsPresenter >> setModelBeforeInitialization: aDomainObject [

	cssFramework := aDomainObject.
]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> updateHtmlSourcePresenter [

	| micContents |
	
	micContents := self owner micDocument contents.	
	self htmlSourcePresenter text: (self convertToHtml: micContents).

]

{ #category : #initialization }
MicCSSStylerDetailsPresenter >> updatePresenter [

	super updatePresenter.
	self cssMetaInfoPresenter
		cssFramework: self cssFramework;
		updatePresenter.
	self cssSourcePresenter text: self cssFramework sourceCode
]
