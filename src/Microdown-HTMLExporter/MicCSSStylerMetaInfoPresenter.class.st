Class {
	#name : #MicCSSStylerMetaInfoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectUrlPresenter',
		'cssLinkPresenter',
		'themesListPresenter',
		'minCssLinkPresenter',
		'normalizeCssLinkPresenter',
		'resetCssLinkPresenter',
		'cssFramework'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicCSSStylerMetaInfoPresenter >> cssFramework [

	^ cssFramework
]

{ #category : #private }
MicCSSStylerMetaInfoPresenter >> cssFramework: aMicCSSFramework [

	cssFramework := aMicCSSFramework
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> cssLinkPresenter [

	^ cssLinkPresenter
]

{ #category : #layout }
MicCSSStylerMetaInfoPresenter >> defaultLayout [

	^ SpGridLayout build: [ : builder |
		builder
			beColumnNotHomogeneous;		
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
			add: themesListPresenter ]
]

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> initializePresenters [ 

	projectUrlPresenter := self newLink label: String empty; yourself.
	cssLinkPresenter := self newLink label: String empty; yourself.
	minCssLinkPresenter := self newLink label: String empty; yourself.
	normalizeCssLinkPresenter := self newLink label: String empty; yourself.
	resetCssLinkPresenter := self newLink label: String empty; yourself.
	themesListPresenter := self newList
		beSingleSelection;
		yourself.

]

{ #category : #private }
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

{ #category : #initialization }
MicCSSStylerMetaInfoPresenter >> setModelBeforeInitialization: aDomainObject [

	cssFramework := aDomainObject
]

{ #category : #accessing }
MicCSSStylerMetaInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #updating }
MicCSSStylerMetaInfoPresenter >> updatePresenter [

	self cssFramework ifNil: [ ^ self ].
	projectUrlPresenter
		url: self cssFramework mainUrl;
		label: 'Visit project web';
		help: 'Open a web browser to visit the main project site'.
	self updatePresenterLinks.
	self cssFramework hasThemes
		ifTrue: [ themesListPresenter items: self cssFramework themes ]

]

{ #category : #updating }
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
