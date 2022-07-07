"
Presents details about the selected CSS library.

"
Class {
	#name : #MicHTMLStylerCSSInfoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectUrlPresenter',
		'cssLinkPresenter',
		'themesListPresenter',
		'minCssLinkPresenter',
		'normalizeCssLinkPresenter',
		'resetCssLinkPresenter',
		'cssFramework',
		'useNormalButton',
		'useMinifiedButton',
		'versionButtons'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicHTMLStylerCSSInfoPresenter >> cssFramework [

	^ cssFramework
]

{ #category : #private }
MicHTMLStylerCSSInfoPresenter >> cssFramework: aMicCSSFramework [

	cssFramework := aMicCSSFramework
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> cssLinkPresenter [

	^ cssLinkPresenter
]

{ #category : #layout }
MicHTMLStylerCSSInfoPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight 
		add: (SpGridLayout build: [ : builder |
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
				add: (SpBoxLayout newLeftToRight
					add: useNormalButton;
					add: useMinifiedButton;
					yourself) ]);
		add: (SpGridLayout build: [ : builder |
			builder 
				add: 'Themes';
				add: themesListPresenter ]);
		yourself
]

{ #category : #initialization }
MicHTMLStylerCSSInfoPresenter >> initializePresenters [ 

	projectUrlPresenter := self newLink label: String empty; yourself.
	cssLinkPresenter := self newLink label: String empty; yourself.
	minCssLinkPresenter := self newLink label: String empty; yourself.
	normalizeCssLinkPresenter := self newLink label: String empty; yourself.
	resetCssLinkPresenter := self newLink label: String empty; yourself.
	themesListPresenter := self newList
		display: #name;
		beSingleSelection;
		yourself.
	useNormalButton := self newRadioButton label: 'Use normal'.
	useMinifiedButton := self newRadioButton label: 'Use minified'.
	useNormalButton associatedRadioButtons: { useMinifiedButton  }.
	versionButtons := Dictionary newFrom: { 
		#normal -> useNormalButton .
		#minified -> useMinifiedButton }.
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> minCssLinkPresenter [

	^ minCssLinkPresenter
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> normalizeCssLinkPresenter [

	^ normalizeCssLinkPresenter
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> projectUrlPresenter [

	^ projectUrlPresenter
]

{ #category : #private }
MicHTMLStylerCSSInfoPresenter >> setLink: aLinkPresenter url: anEmptyStringOrUrl help: helpString [

	anEmptyStringOrUrl isEmpty
		ifTrue: [ 
			aLinkPresenter
				color: Color black;
				label: 'Not Available' ]
		ifFalse: [ 
			aLinkPresenter 
				url: anEmptyStringOrUrl;
				label: anEmptyStringOrUrl;
				help: helpString ]
]

{ #category : #initialization }
MicHTMLStylerCSSInfoPresenter >> setModelBeforeInitialization: aDomainObject [

	cssFramework := aDomainObject
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #updating }
MicHTMLStylerCSSInfoPresenter >> updatePresenter [

	self cssFramework ifNil: [ ^ self ].
	projectUrlPresenter
		url: self cssFramework mainUrl;
		label: 'Visit project web';
		help: 'Open a web browser to visit the main project site'.
	self updatePresenterLinks.
	(self cssFramework hasThemes and: [ self useNormalButton state ])
		ifTrue: [ themesListPresenter items: self cssFramework normalThemes ]
		ifFalse: [ themesListPresenter items: self cssFramework minThemes ]

]

{ #category : #updating }
MicHTMLStylerCSSInfoPresenter >> updatePresenterLinks [

	{ 
		{ cssLinkPresenter . self cssFramework cssUrl . 'Open a web browser to visit the CSS file' } .
		{ minCssLinkPresenter . self cssFramework minCssUrl . 'Open a web browser to visit the minified CSS file' } .
		{ normalizeCssLinkPresenter . self cssFramework normalizeUrl . 'Open a web browser to visit the Normalize CSS file' } .
		{ resetCssLinkPresenter . self cssFramework resetUrl . 'Open a web browser to visit the Reset CSS file' } 
	} do: [ : linkArray |
		self 
			setLink: linkArray first 
			url: linkArray second 
			help: linkArray third ]
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> useMinifiedButton [

	^ useMinifiedButton
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> useMinifiedButton: anObject [

	useMinifiedButton := anObject
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> useNormalButton [

	^ useNormalButton
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> useNormalButton: anObject [

	useNormalButton := anObject
]
