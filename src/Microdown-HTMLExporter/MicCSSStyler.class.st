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

{ #category : #'accessing - toolbar' }
MicCSSStyler >> addToolbarCommandsTo: aGroup [

	self toolbarCommands do: [ :each | 
		aGroup register: (each forSpecContext: self) ]
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> baseToolbarCommands [

	^ { 
		MicCSSStylerPreviewCommand .
		MicCSSStylerPublishCommand .
		MicCSSStylerExportCommand .
		MicCSSStylerUpdateCommand
		}
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

	^ SpBoxLayout newTopToBottom 
		add: toolbarPresenter height: self class toolbarHeight + 15;	
		add:  (SpPanedLayout newLeftToRight
			positionOfSlider: 20 percent;
			add: cssListPresenter;
			add: cssDetailsPresenter;
			yourself);
		yourself
]

{ #category : #initialization }
MicCSSStyler >> frameworks [
	"Answer a <Collection> with CSS libraries"
	
	^ self cssProvider frameworks
]

{ #category : #testing }
MicCSSStyler >> hasMicDocument [
	"Answer <true> if the receiver has a Microdown documennt supplied by the user"

	^ self micDocument notNil
]

{ #category : #accessing }
MicCSSStyler >> iconForWindow [
	"Answer a Form to be used during initialization when opening in a SpWindowPresenter."

	^ self iconNamed: #smallWindow
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
		windowIcon: self iconForWindow;
		whenClosedDo: [ self ].
]

{ #category : #accessing }
MicCSSStyler >> micDocument [

	^ micDocument
]

{ #category : #accessing }
MicCSSStyler >> micDocument: anObject [

	micDocument := anObject.
	self updatePresenter.
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> optionalToolbarCommands [
	"Show opening button if this tool was opened externally, i.e. without a user document"

	self hasMicDocument
		ifFalse: [ ^ { MicCSSStylerOpenCommand } ].
	^ Array empty 
]

{ #category : #initialization }
MicCSSStyler >> title [
	" Private - See superimplementor's comment "

	^ 'Microdown CSS Styler'
]

{ #category : #accessing }
MicCSSStyler >> titleForWindow [ 

	^ self hasMicDocument 
		ifTrue: [ self title , ' on: ' , self micDocument basename ]
		ifFalse: [ self title ]
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarActions [

	^ CmCommandGroup forSpec
		in: [ :this | self addToolbarCommandsTo: this ];
		yourself
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> toolbarCommands [

	^ self baseToolbarCommands , self optionalToolbarCommands sorted: #order ascending
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

{ #category : #updating }
MicCSSStyler >> updateHtmlSourcePresenter [

	self hasMicDocument 
		ifTrue: [ self cssDetailsPresenter updateHtmlSourcePresenter ]
]

{ #category : #updating }
MicCSSStyler >> updatePresenter [

	super updatePresenter.
	self 
		updateTitle;
		updateHtmlSourcePresenter.
	
]

{ #category : #updating }
MicCSSStyler >> updateTitle [
	
	self withWindowDo: [ :aWindow | aWindow title: self titleForWindow ]
]
