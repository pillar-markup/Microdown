Class {
	#name : #MicCSSStyler,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbarPresenter',
		'cssDetailsPresenter',
		'cssProvider',
		'cssListPresenter',
		'cssFramework'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicCSSStyler class >> baseToolbarCommands [

	^ { 
		StPlaygroundDoItCommand.
		StPlaygroundPublishCommand.
		StPlaygroundBindingsCommand.				
		StPlaygroundVersionsCommand.
		StPlaygroundPagesCommand.
	}
]

{ #category : #'instance creation' }
MicCSSStyler class >> open [
	<example>

	^ self new open.
]

{ #category : #private }
MicCSSStyler class >> toolbarCommands [

	^ self baseToolbarCommands sorted: #order ascending
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> addToolbarCommandsTo: aGroup [

	self class toolbarCommands do: [ :each | 
		aGroup register: (each forSpecContext: self) ]
]

{ #category : #accessing }
MicCSSStyler >> cssDetailsPresenter [
	" Answer the cssRepositoryContainerPresenter of this MicCSSStyler "

	^ cssDetailsPresenter
]

{ #category : #initialization }
MicCSSStyler >> cssFramework [ 
	"Answer a <MicCSSFramework>"
	
	^ self frameworks first
]

{ #category : #accessing }
MicCSSStyler >> cssListPresenter [

	^ cssListPresenter
]

{ #category : #initialization }
MicCSSStyler >> cssProvider [

	^ cssProvider
		ifNil: [ cssProvider := MicCSSProvider new ]
]

{ #category : #layout }
MicCSSStyler >> defaultLayout [

	^ self layout: (SpBoxLayout newTopToBottom 
		add:  (SpPanedLayout newLeftToRight
			positionOfSlider: 20 percent;
			add: cssListPresenter;
			add: cssDetailsPresenter;
			yourself);
		yourself)
]

{ #category : #initialization }
MicCSSStyler >> frameworks [
	"Answer a <Collection> with CSS libraries"
	
	^ self cssProvider frameworks
]

{ #category : #initialization }
MicCSSStyler >> initializeFocus [
	" Private - See superimplementor's comment "

	self focusOrder
		add: self cssListPresenter;
		add: self toolbarPresenter;
		add: self cssDetailsPresenter.
]

{ #category : #initialization }
MicCSSStyler >> initializePresenters [
	" Private - See superimplementor's comment "

	toolbarPresenter := self newToolbar
		addStyle: 'stToolbar';	
		displayMode: self toolbarDisplayMode;
		beIcons;
		fillWith: self toolbarActions;
		yourself.		
	cssDetailsPresenter := self instantiate: MicCSSStylerDetailsPresenter on: self cssFramework.
	cssListPresenter := self newList
		enableSearch;
		beSingleSelection;
		display: #name;
		whenSelectionChangedDo: [ : selectionMode | 
			selectionMode selectedItem
				ifNotNil: [ : micCSSFrw |  self cssDetailsPresenter cssFramework: micCSSFrw ] ];
		items: self frameworks;
		sortingBlock: [ : a : b | a name < b name ];
		headerTitle: 'Styles';
		yourself.
	cssListPresenter items 
		ifNotEmpty: [ cssListPresenter selectIndex: 1 ]
		ifEmpty: [ self cssDetailsPresenter updatePresenter ]

]

{ #category : #initialization }
MicCSSStyler >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: 950 @ 650;
		whenClosedDo: [ self ].
]

{ #category : #initialization }
MicCSSStyler >> title [
	" Private - See superimplementor's comment "

	^ 'Microdown CSS Styler'
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarActions [

	^ CmCommandGroup forSpec
		in: [ :this | self addToolbarCommandsTo: this ];
		yourself
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarDisplayMode [

	^ StPharoSettings toolbarDisplayMode
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarPresenter [
	" Answer the toolbarPresenter of this MicCSSStyler "

	^ toolbarPresenter
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarPresenter: anObject [
	" Sets the toolbarPresenter of this MicCSSStyler "

	toolbarPresenter := anObject
]
