"
A Spec user-interface to browse and apply a CSS style to a Microdown document.

Evaluate the following expression to open it in a browsing mode (only to view available CSS frameworks):

```language=Pharo
MicHTMLStyler open.
```

To open on a Microdown document, evaluate:

```language=Pharo
MicHTMLStyler openOn: MicDocFactory exampleMic.
```

"
Class {
	#name : #MicHTMLStyler,
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
MicHTMLStyler class >> open [
	<script>

	^ self new open.
]

{ #category : #'instance creation' }
MicHTMLStyler class >> openOn: aMicrodownString [

	self new
		micDocumentString: aMicrodownString;
		openWithSpec.
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> addToolbarCommandsTo: aGroup [

	self toolbarCommands do: [ :each | 
		aGroup register: (each forSpecContext: self) ]
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> baseToolbarCommands [

	^ { 
		MicCSSStylerPreviewCommand .
		MicCSSStylerHelpCommand .
		MicCSSStylerExportCommand .
		MicCSSStylerUpdateCommand .
		MicCSSStylerQuitCommand
		}
]

{ #category : #accessing }
MicHTMLStyler >> cssDetailsPresenter [
	" Answer the Notebook container of this MicCSSStyler "

	^ stylerNotebookPresenter
]

{ #category : #initialization }
MicHTMLStyler >> cssFramework [ 
	"Answer a <MicCSSFramework>"
	
	^ self cssListPresenter ifNotNil: [ : cssList |
		cssList selectedItem ]
]

{ #category : #accessing }
MicHTMLStyler >> cssFramework: aMicCSSFramework [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
MicHTMLStyler >> cssListPresenter [

	^ cssListPresenter
]

{ #category : #initialization }
MicHTMLStyler >> cssProvider [
	"Answer a <MicCSSProvider> which handles provisioning of CSS frameworks to the receiver"

	^ cssProvider
		ifNil: [ cssProvider := MicCSSProvider new ]
]

{ #category : #accessing }
MicHTMLStyler >> cssTheme [
	"Answer the currently selected MicCSSTheme"
	
	^ self cssDetailsPresenter cssTheme
]

{ #category : #layout }
MicHTMLStyler >> defaultLayout [

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
MicHTMLStyler >> frameworks [
	"Answer a <Collection> with CSS libraries"
	
	^ self cssProvider frameworks
]

{ #category : #testing }
MicHTMLStyler >> hasCssSelection [

	^ self cssListPresenter notNil and: [ 
		  self cssListPresenter selection isEmpty not ]
]

{ #category : #testing }
MicHTMLStyler >> hasMicDocument [
	"Answer <true> if the receiver has a Microdown HTML document opened"

	^ micHtmlDocument notNil
]

{ #category : #testing }
MicHTMLStyler >> hasMicDocumentFileRef [
	"Answer <true> if the receiver has a Microdown documennt supplied by the user"

	^ micDocumentFileRef notNil
]

{ #category : #testing }
MicHTMLStyler >> hasMicDocumentString [
	"Answer <true> if the receiver has a Microdown documennt supplied by the user"

	^ micDocumentString notNil
]

{ #category : #testing }
MicHTMLStyler >> hasMicHtmlDocument [
	"Answer <true> if there is content in the HTML preview presenter"

	^ self cssDetailsPresenter hasMicHtmlDocument 
]

{ #category : #testing }
MicHTMLStyler >> hasThemeSelection [

	^ self cssDetailsPresenter hasThemeSelection
]

{ #category : #accessing }
MicHTMLStyler >> iconForWindow [
	"Answer a Form to be used during initialization when opening in a SpWindowPresenter."

	^ self iconNamed: #smallWindow
]

{ #category : #initialization }
MicHTMLStyler >> initialize [
	"Private - Initialize the receiver's frameworks before UI display"

	self cssProvider hasFrameworksInstalled
		ifFalse: [ self cssProvider installFrameworks ].
	super initialize.
]

{ #category : #initialization }
MicHTMLStyler >> initializeDetailPresenter [

	stylerNotebookPresenter := self instantiate: MicHTMLStylerDetailViewsPresenter on: self.
]

{ #category : #initialization }
MicHTMLStyler >> initializeFocus [
	" Private - See superimplementor's comment "

	self focusOrder
		add: self cssListPresenter;
		add: self toolbarPresenter;
		add: self cssDetailsPresenter.
]

{ #category : #initialization }
MicHTMLStyler >> initializeListPresenter [

	cssListPresenter := self newList
		enableSearch;
		beSingleSelection;
		display: #name;
		whenSelectionChangedDo: [ : selectionMode | 
			selectionMode selectedItem
				ifNotNil: [ : micCSSFrw | self updatePresenter ] ];
		items: self frameworks;
		sortingBlock: [ : a : b | a name < b name ];
		headerTitle: 'Styles';
		yourself.
	cssListPresenter items 
		ifNotEmpty: [ cssListPresenter selectIndex: 0 ]
		ifEmpty: [ self cssDetailsPresenter updatePresenter ]
]

{ #category : #initialization }
MicHTMLStyler >> initializePresenters [
	" Private - See superimplementor's comment "

	self initializeToolbar.
	self initializeListPresenter.	
	self initializeDetailPresenter.

]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> initializeToolbar [

	toolbarPresenter := self newToolbar
		fillWith: self toolbarActions;
		yourself.
]

{ #category : #initialization }
MicHTMLStyler >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: 950 @ 650;
		windowIcon: self iconForWindow;
		whenClosedDo: [ self ].

]

{ #category : #testing }
MicHTMLStyler >> isOverwrite [
	"Answer <true> if receiver is set to overwrite on exporting"
	
	^ self cssDetailsPresenter isOverwrite
]

{ #category : #accessing }
MicHTMLStyler >> micDocumentContents [
	"Answer a <String> representing Microdown contents taken from the receiver. 
	We could have a micDocumentFileRef pointing to an existing .mic file or 
	we could have a micDocumentString being a unsaved new Microdown document"
	
	^ self hasMicDocumentFileRef 
		ifTrue: [ 
			micDocumentFileRef exists
				ifFalse: [ self error: 'File moved or deleted' ].
			micDocumentFileRef contents ]
		ifFalse: [ micDocumentString  ]
]

{ #category : #accessing }
MicHTMLStyler >> micDocumentFileRef [

	^ micDocumentFileRef
]

{ #category : #accessing }
MicHTMLStyler >> micDocumentFileRef: aFileReference [
	"A document has been opened, update the receiver's views"

	micDocumentFileRef := aFileReference.
	micDocumentString := aFileReference contents.
	self updatePresenter.
]

{ #category : #accessing }
MicHTMLStyler >> micDocumentString [

	^ micDocumentString
]

{ #category : #accessing }
MicHTMLStyler >> micDocumentString: anObject [

	micDocumentString := anObject
]

{ #category : #accessing }
MicHTMLStyler >> micHtmlDocument [

	^ micHtmlDocument
]

{ #category : #accessing }
MicHTMLStyler >> micHtmlDocument: anObject [

	micHtmlDocument := anObject
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> optionalToolbarCommands [
	"Show opening button if this tool was opened externally, i.e. without a user document"

	self hasMicDocumentString
		ifFalse: [ ^ { MicCSSStylerOpenCommand } ].
	^ Array empty 
]

{ #category : #accessing }
MicHTMLStyler >> selectedCssFramework [

	^ self cssListPresenter
		ifNotNil: [ : cssFrameworkList | cssFrameworkList selectedItem ]
]

{ #category : #initialization }
MicHTMLStyler >> title [
	" Private - See superimplementor's comment "

	^ 'Microdown HTML Styler'
]

{ #category : #accessing }
MicHTMLStyler >> titleForWindow [ 

	^ self hasMicDocumentFileRef
		ifTrue: [ self title , ' on: ' , self micDocumentFileRef basename ]
		ifFalse: [ self title ]
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> toolbarActions [

	^ CmCommandGroup forSpec
		in: [ :this | self addToolbarCommandsTo: this ];
		yourself
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> toolbarCommands [

	^ self baseToolbarCommands , self optionalToolbarCommands sorted: #order ascending
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> toolbarPresenter [
	" Answer the toolbarPresenter of this MicCSSStyler "

	^ toolbarPresenter
]

{ #category : #'accessing - toolbar' }
MicHTMLStyler >> toolbarPresenter: anObject [
	" Sets the toolbarPresenter of this MicCSSStyler "

	toolbarPresenter := anObject
]

{ #category : #updating }
MicHTMLStyler >> updateCssSelection [

	| selectedCss |
	
	self hasCssSelection 
		ifFalse: [ ^ self ].
   selectedCss := self hasThemeSelection
      ifTrue: [ self cssTheme ]
      ifFalse: [ self cssFramework ].
    self micHtmlDocument addCSS: selectedCss.
]

{ #category : #updating }
MicHTMLStyler >> updateHtmlOptionsPresenter [

	self cssDetailsPresenter updateHtmlOptionsPresenter
]

{ #category : #updating }
MicHTMLStyler >> updateHtmlSourcePresenter [
	"Update the HTML source presenter only if we have a FileReference to it, i.e. a Microdown file was opened. We still allow MicHTMLDoc to be present because the user could set options before opening a Microdown file"

	self hasMicDocumentFileRef
		ifTrue: [ self cssDetailsPresenter updateHtmlSourcePresenter ]
]

{ #category : #updating }
MicHTMLStyler >> updateMicHtmlDocument [
	"Answer a new Microdown HTML document configured with the receiver's settings"
	
	self micHtmlDocument: MicHTMLDoc new.
	self updateCssSelection.
	self hasMicDocumentFileRef 
		ifTrue: [ self micHtmlDocument fileName: self micDocumentFileRef withoutExtension basename , '.html' ].
	self micHtmlDocument 
		destinationPath: self cssDetailsPresenter destinationPath;
		fromMicrodown: self micDocumentContents
]

{ #category : #initialization }
MicHTMLStyler >> updatePresenter [

	super updatePresenter.
	self cssDetailsPresenter updatePresenter	.
	self updateTitle.
	self 
		updateMicHtmlDocument;
		updateHtmlSourcePresenter;
		updateHtmlOptionsPresenter.

]

{ #category : #updating }
MicHTMLStyler >> updateTitle [
	
	self withWindowDo: [ :aWindow | aWindow title: self titleForWindow ]
]
