"
Presents details about the selected CSS library.

"
Class {
	#name : #MicHTMLStylerCSSInfoPresenter,
	#superclass : #MicHTMLStylerAbstractPresenter,
	#instVars : [
		'projectUrlPresenter',
		'cssLinkPresenter',
		'themesListPresenter',
		'minCssLinkPresenter',
		'normalizeCssLinkPresenter',
		'resetCssLinkPresenter',
		'useNormalButton',
		'useMinifiedButton',
		'versionButtons'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicHTMLStylerCSSInfoPresenter >> cssFramework [

	^ self styler cssFramework
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> cssLinkPresenter [

	^ cssLinkPresenter
]

{ #category : #layout }
MicHTMLStylerCSSInfoPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight 
		add: themesListPresenter expand: false fill: true padding: 10;	
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
				add: 'Versions';
				add: (SpBoxLayout newTopToBottom
					add: useNormalButton;
					add: useMinifiedButton;
					yourself) ]);
		yourself
]

{ #category : #testing }
MicHTMLStylerCSSInfoPresenter >> hasThemeSelection [

	^ self themesListPresenter selection isEmpty not
]

{ #category : #initialization }
MicHTMLStylerCSSInfoPresenter >> initializePresenters [ 

	projectUrlPresenter := self newLink label: String empty; yourself.
	cssLinkPresenter := self newLink label: String empty; yourself.
	minCssLinkPresenter := self newLink label: String empty; yourself.
	normalizeCssLinkPresenter := self newLink label: String empty; yourself.
	resetCssLinkPresenter := self newLink label: String empty; yourself.
	themesListPresenter := self newList
		beSingleSelection;
		display: #name;
		headerTitle: 'Themes';
		items: (OrderedCollection new: 10);
		sortingBlock: [ : a : b | a name < b name ];
		yourself.
	useNormalButton := self newRadioButton 
		label: 'Use normal';
		whenActivatedDo: [ self updatePresenter ];
		yourself.
	useMinifiedButton := self newRadioButton 
		label: 'Use minified';
		whenActivatedDo: [ self updatePresenter ];
		yourself.
	useNormalButton associatedRadioButtons: { useMinifiedButton  }.
	versionButtons := Dictionary newFrom: { 
		#normal -> useNormalButton .
		#minified -> useMinifiedButton }.
]

{ #category : #testing }
MicHTMLStylerCSSInfoPresenter >> isMinifiedSelection [
	"Answer <true> if the minified version option is selected"

	^ self useMinifiedButton state
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

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #updating }
MicHTMLStylerCSSInfoPresenter >> updatePresenter [

	super updatePresenter.
	self cssFramework ifNil: [ ^ self ].
	projectUrlPresenter
		url: self cssFramework projectUrl;
		label: 'Visit project web';
		help: 'Open a web browser to visit the main project site'.
	self updatePresenterLinks.
	self updatePresenterRadioOptions.
	self stylerDetailsPresenter updateSourceCodePresenter.
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

{ #category : #updating }
MicHTMLStylerCSSInfoPresenter >> updatePresenterRadioOptions [

	self useNormalButton enable.
	self useMinifiedButton enable.
	(self cssFramework hasNormalThemes and: [ self useNormalButton state ])
		ifTrue: [ 
			themesListPresenter items: self cssFramework normalThemes.
			self useMinifiedButton state: false.
			self cssFramework hasMinifiedVersion 
				ifFalse: [ self useMinifiedButton disable ].
			self useNormalButton state: true ]
		ifFalse: [ 
			themesListPresenter items: self cssFramework minThemes.
			self useNormalButton state: false.			
			self cssFramework hasNormalVersion
				ifFalse: [ self useNormalButton disable ].
			self useMinifiedButton state: true ]

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
