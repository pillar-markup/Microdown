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
		'cssProvider',
		'cssListPresenter',
		'micDocumentString',
		'micHtmlDocument',
		'micDocumentFileRef',
		'stylerNotebookPresenter'
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
		micDocumentString: aMicrodownString;
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

	^ stylerNotebookPresenter
]

{ #category : #initialization }
MicCSSStyler >> cssFramework [ 
	"Answer a <MicCSSFramework>"
	
	^ self cssListPresenter ifNotNil: [ : cssList |
		cssList selectedItem ]
]

{ #category : #accessing }
MicCSSStyler >> cssFramework: aMicCSSFramework [ 
	self shouldBeImplemented.
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
			add: stylerNotebookPresenter;
			yourself);
		yourself
]

{ #category : #initialization }
MicCSSStyler >> frameworks [
	"Answer a <Collection> with CSS libraries"
	
	^ self cssProvider frameworks
]

{ #category : #testing }
MicCSSStyler >> hasCssSelection [

	^ self cssListPresenter notNil and: [ 
		  self cssListPresenter selection isEmpty not ]
]

{ #category : #testing }
MicCSSStyler >> hasMicDocument [
	"Answer <true> if the receiver has a Microdown HTML document opened"

	^ micHtmlDocument notNil
]

{ #category : #testing }
MicCSSStyler >> hasMicDocumentFileRef [
	"Answer <true> if the receiver has a Microdown documennt supplied by the user"

	^ micDocumentFileRef notNil
]

{ #category : #testing }
MicCSSStyler >> hasMicDocumentString [
	"Answer <true> if the receiver has a Microdown documennt supplied by the user"

	^ micDocumentString notNil
]

{ #category : #testing }
MicCSSStyler >> hasMicHtmlDocument [
	"Answer <true> if there is content in the HTML preview presenter"

	^ self cssDetailsPresenter hasMicHtmlDocument 
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

	stylerNotebookPresenter := self instantiate: MicCSSStylerDetailViewsPresenter on: self.
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
				ifNotNil: [ : micCSSFrw | self cssDetailsPresenter updatePresenter ] ];
		items: self frameworks;
		sortingBlock: [ : a : b | a name < b name ];
		headerTitle: 'Styles';
		yourself.
	cssListPresenter items 
		ifNotEmpty: [ cssListPresenter selectIndex: 0 ]
		ifEmpty: [ self cssDetailsPresenter updatePresenter ]
]

{ #category : #initialization }
MicCSSStyler >> initializePresenters [
	" Private - See superimplementor's comment "

	self initializeToolbar.
	self initializeListPresenter.	
	self initializeDetailPresenter.

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

{ #category : #testing }
MicCSSStyler >> isOverwrite [
	"Answer <true> if receiver is set to overwrite on exporting"
	
	^ self cssDetailsPresenter isOverwrite
]

{ #category : #accessing }
MicCSSStyler >> micDocumentContents [
	"Answer a <String> representing Microdown contents taken from the receiver. 
	We could have a micDocumentFileRef pointing to an existing .mic file or 
	we could have a micDocumentString being a unsaved new Microdown document"
	
	^ self hasMicDocumentFileRef 
		ifTrue: [ micDocumentFileRef contents ]
		ifFalse: [ micDocumentString  ]
]

{ #category : #accessing }
MicCSSStyler >> micDocumentFileRef [

	^ micDocumentFileRef
]

{ #category : #accessing }
MicCSSStyler >> micDocumentFileRef: anObject [
	"A document has been opened, update the receiver's views"

	micDocumentFileRef := anObject.
	self updatePresenter.
]

{ #category : #accessing }
MicCSSStyler >> micDocumentString [

	^ micDocumentString
]

{ #category : #accessing }
MicCSSStyler >> micDocumentString: anObject [

	micDocumentString := anObject
]

{ #category : #accessing }
MicCSSStyler >> micHtmlDocument [

	^ micHtmlDocument
]

{ #category : #accessing }
MicCSSStyler >> micHtmlDocument: anObject [

	micHtmlDocument := anObject
]

{ #category : #'accessing - toolbar' }
MicCSSStyler >> optionalToolbarCommands [
	"Show opening button if this tool was opened externally, i.e. without a user document"

	self hasMicDocumentString
		ifFalse: [ ^ { MicCSSStylerOpenCommand } ].
	^ Array empty 
]

{ #category : #accessing }
MicCSSStyler >> selectedCssFramework [

	^ self cssListPresenter
		ifNotNil: [ : cssFrameworkList | cssFrameworkList selectedItem ]
]

{ #category : #initialization }
MicCSSStyler >> title [
	" Private - See superimplementor's comment "

	^ 'Microdown CSS Styler'
]

{ #category : #accessing }
MicCSSStyler >> titleForWindow [ 

	^ self hasMicDocumentFileRef
		ifTrue: [ self title , ' on: ' , self micDocumentFileRef basename ]
		ifFalse: [ 
			self hasMicDocumentString
				ifTrue: [ self title , ' on: <Unsaved document>' ]
				ifFalse: [ self title ] ]
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
MicCSSStyler >> updateHtmlOptionsPresenter [

	self cssDetailsPresenter updateHtmlOptionsPresenter
]

{ #category : #updating }
MicCSSStyler >> updateHtmlSourcePresenter [

	(self hasMicDocumentString or: [ self hasMicDocumentFileRef ])
		ifTrue: [ self cssDetailsPresenter updateHtmlSourcePresenter ]
]

{ #category : #updating }
MicCSSStyler >> updateMicHtmlDocument [
	"Answer a new Microdown HTML document configured with the receiver's settings"
	
	self micHtmlDocument: MicHTMLDoc new.
	self hasCssSelection
		ifTrue: [ self micHtmlDocument addCSSNamed: self cssFramework name ].
	self hasMicDocumentFileRef 
		ifTrue: [ self micHtmlDocument fileName: self micDocumentFileRef withoutExtension basename , '.html' ].
	self micHtmlDocument fromMicrodown: self micDocumentContents
]

{ #category : #updating }
MicCSSStyler >> updatePresenter [

	super updatePresenter.
	self updateTitle.
	self 
		updateMicHtmlDocument;
		updateHtmlSourcePresenter;
		updateHtmlOptionsPresenter.

]

{ #category : #updating }
MicCSSStyler >> updateTitle [
	
	self withWindowDo: [ :aWindow | aWindow title: self titleForWindow ]
]
