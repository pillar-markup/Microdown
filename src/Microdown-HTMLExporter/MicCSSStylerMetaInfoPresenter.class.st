Class {
	#name : #MicCSSStylerMetaInfoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectUrlPresenter',
		'cssLinkPresenter',
		'themesListPresenter',
		'minCssLinkPresenter',
		'normalizeCssLinkPresenter',
		'resetCssLinkPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicCSSStylerMetaInfoPresenter >> cssFramework [

	^ self owner cssFramework
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> cssLinkPresenter [

	^ cssLinkPresenter
]

{ #category : #layout }
MicCSSStylerMetaInfoPresenter >> defaultLayout [

	^ self layout: (SpGridLayout build: [ : builder |
		builder
			add: 'Repository';
			add: projectUrlPresenter;
			nextRow;
			add: 'CSS';
			add: cssLinkPresenter;
			nextRow;
			add: 'Minified CSS';
			add: minCssLinkPresenter;
			nextRow;
			add: 'Normalize CSS';
			add: normalizeCssLinkPresenter;
			nextRow;
			add: 'Reset CSS';
			add: resetCssLinkPresenter;
			nextRow;
			add: 'Themes';
			add: themesListPresenter ])
]

{ #category : #layout }
MicCSSStylerMetaInfoPresenter >> initializePresenters [ 

	projectUrlPresenter := self newLink.
	cssLinkPresenter := self newLink.
	minCssLinkPresenter := self newLink.
	normalizeCssLinkPresenter := self newLink.
	resetCssLinkPresenter := self newLink.
	themesListPresenter := self newList
		beSingleSelection;
		yourself.

]

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> labelIfAvailable: aString [
	"Answer a <String> with a friendly description if it's empty"

	aString ifEmpty: [ ^ 'Not Available' ].
	^ aString
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> minCssLinkPresenter [

	^ minCssLinkPresenter
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> normalizeCssLinkPresenter [

	^ normalizeCssLinkPresenter
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> projectUrlPresenter [

	^ projectUrlPresenter
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> updatePresenter [

	projectUrlPresenter
		url: self cssFramework mainUrl;
		label: self cssFramework mainUrl;
		help: 'Open a web browser to visit the main project site'.
	self updatePresenterLinks.
	self cssFramework hasThemes
		ifTrue: [ themesListPresenter items: self cssFramework themes ]

]

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> updatePresenterLinks [

	cssLinkPresenter
		url: self cssFramework cssUrl;	
		label: (self labelIfAvailable: self cssFramework cssUrl);
		help: 'Open a web browser to visit the CSS file'.
	minCssLinkPresenter 
		url: self cssFramework minCssUrl;	
		label: (self labelIfAvailable: self cssFramework minCssUrl);
		help: 'Open a web browser to visit the minified CSS file'.
	normalizeCssLinkPresenter 
		url: self cssFramework normalizeUrl;	
		label: (self labelIfAvailable: self cssFramework normalizeUrl);
		help: 'Open a web browser to visit the Normalize CSS file'.
	resetCssLinkPresenter
		url: self cssFramework resetUrl;	
		label: (self labelIfAvailable: self cssFramework resetUrl);
		help: 'Open a web browser to visit the Reset CSS file'.
]
