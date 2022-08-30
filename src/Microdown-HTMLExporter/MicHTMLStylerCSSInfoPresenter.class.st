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

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> cssTheme [
	"Answer the currently selected <MicCSSTheme>"

	^ themesListPresenter selectedItem 
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
	self initializeThemesPresenter.
	self initializeVersionOptions.
]

{ #category : #initialization }
MicHTMLStylerCSSInfoPresenter >> initializeThemesPresenter [

	themesListPresenter := self newList
		beSingleSelection;
		display: #name;
		headerTitle: 'Themes';
		items: OrderedCollection new;
		sortingBlock: [ : a : b | a name < b name ];
		whenSelectionChangedDo: [ : selectionMode | 
			selectionMode selectedItem
				ifNotNil: [ : micCSSTheme | 	
						self updatePresenterRadioOptions.
						self stylerDetailsPresenter 
							updatePresentersAfterThemeSelection;
							updateSourceCodePresenter ] ];
		yourself.
]

{ #category : #initialization }
MicHTMLStylerCSSInfoPresenter >> initializeVersionOptions [

	useNormalButton := self newRadioButton 
		label: 'Use normal';
		whenActivatedDo: [ 
			useMinifiedButton state: false. 
			self updatePresenter ];
		yourself.
	useMinifiedButton := self newRadioButton 
		label: 'Use minified';
		whenActivatedDo: [ 
			useNormalButton state: false.
			self updatePresenter ];
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

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> resetCssLinkPresenter [

	^ resetCssLinkPresenter
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
MicHTMLStylerCSSInfoPresenter >> themeSelection [

	^ themesListPresenter selectedItem
]

{ #category : #accessing }
MicHTMLStylerCSSInfoPresenter >> themesListPresenter [

	^ themesListPresenter
]

{ #category : #initialization }
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
		{ self cssLinkPresenter . self cssFramework cssUrl . 'Open a web browser to visit the CSS file' } .
		{ self minCssLinkPresenter . self cssFramework minCssUrl . 'Open a web browser to visit the minified CSS file' } .
		{ self normalizeCssLinkPresenter . self cssFramework normalizeUrl . 'Open a web browser to visit the Normalize CSS file' } .
		{ self resetCssLinkPresenter . self cssFramework resetUrl . 'Open a web browser to visit the Reset CSS file' } 
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

	self cssFramework hasThemes
		ifTrue: [ 
			themesListPresenter items: self cssFramework themes.
			self cssFramework hasNormalThemes
				ifFalse: [ 
					self useNormalButton disable.
					self useMinifiedButton state: true ].
			self cssFramework hasMinifiedThemes 
				ifFalse: [ 
					self useMinifiedButton disable.
					self useNormalButton state: true ] ]
		ifFalse: [
			themesListPresenter items: OrderedCollection new.
			self cssFramework hasNormalVersion
				ifFalse: [ 
					self useNormalButton disable.
					self useMinifiedButton state: true ].
			self cssFramework hasMinifiedVersion 
				ifFalse: [ 
					self useMinifiedButton disable.
					self useNormalButton state: true ] ]
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
