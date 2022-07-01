"
A Spec user-interface to browse and apply a CSS style to a Microdown document.

Evaluate the following expression to open it in a browsing mode (only to view available CSS frameworks):

```language=Pharo
MicCSSStyler open.
```

To open on a Microdown document, evaluate:

```language=Pharo
MicCSSStyler openOn: MicDocFactory exampleMic.
```

"
Class {
	#name : #MicCSSStyler,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbarPresenter',
		'cssDetailsPresenter',
		'cssProvider',
		'cssListPresenter',
		'micDocument'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #private }
MicCSSStyler class >> baseToolbarCommands [

	^ { 
		MicCSSStylerPreviewCommand .
		MicCSSStylerPublishCommand .
		MicCSSStylerExportCommand .
		MicCSSStylerUpdateCommand
		}
]

{ #category : #'instance creation' }
MicCSSStyler class >> open [
	<script>

	^ self new open.
]

{ #category : #'instance creation' }
MicCSSStyler class >> openOn: aMicrodownString [

	self new
		micDocument: aMicrodownString;
		openWithSpec.
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
	"Answer a <MicCSSProvider> which handles provisioning of CSS frameworks to the receiver"

	^ cssProvider
		ifNil: [ cssProvider := MicCSSProvider new ]
]

{ #category : #layout }
MicCSSStyler >> defaultLayout [

	^ self layout: (SpBoxLayout newTopToBottom 
		add: toolbarPresenter height: self class toolbarHeight + 15;	
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
MicCSSStyler >> initialize [
	"Private - Initialize the receiver's frameworks before UI display"

	self cssProvider hasFrameworksInstalled
		ifFalse: [ self cssProvider installFrameworks ].

	super initialize.
]

{ #category : #initialization }
MicCSSStyler >> initializeDetailPresenter [

	cssDetailsPresenter := self instantiate: MicCSSStylerDetailsPresenter on: self cssFramework.
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
MicCSSStyler >> initializeListPresenter [

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
MicCSSStyler >> initializePresenters [
	" Private - See superimplementor's comment "

	self initializeToolbar.
	self initializeDetailPresenter.
	self initializeListPresenter.

]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> initializeToolbar [

	toolbarPresenter := self newToolbar
		fillWith: self toolbarActions;
		yourself.
]

{ #category : #initialization }
MicCSSStyler >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: 950 @ 650;
		whenClosedDo: [ self ].
]

{ #category : #accessing }
MicCSSStyler >> micDocument [

	^ micDocument
]

{ #category : #accessing }
MicCSSStyler >> micDocument: anObject [

	micDocument := anObject
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
MicCSSStyler >> toolbarPresenter [
	" Answer the toolbarPresenter of this MicCSSStyler "

	^ toolbarPresenter
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarPresenter: anObject [
	" Sets the toolbarPresenter of this MicCSSStyler "

	toolbarPresenter := anObject
]
