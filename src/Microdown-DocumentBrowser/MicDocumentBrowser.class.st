"
I am a browser of collections of microdown documents.

I am work in progress, but reasonable functional.

I open by `MicDocumentBrowser class >> #open`, or a specific document using: `MicDocumentBrowser class >> #openDocument:` which takes a `MicAbsoluteResourceReference` or a `String URI` as argument. 

Editing is done using the little edit flag in the lower right corner - there is currently no keyboard shortcut for this.
I can save some documents, but not all. I can save documents on files, and package/class comments. In particular I **cannot** save to github or the web. Saving is done on the save button when it is not greyed out.

I open with some documents being loaded, those are currently defined in `MicDocumentBrowser >>#defaultDocumentRoots`. 

The roots loaded at the moment is:
- all class and package comments in the Microdown project (read and write)
- all docs found on github relating to Microdown (read-only as one do not write to github)
- all doc(s) folders found in iceberg workspace (read and write). This will be the th doc-folders of projects known by iceberg.
## Auto saving
Moving to an other document or closing the browser will save changes made in source

## Preventing cyclic events
In order to prevent cycles in the events, all methods called through gui actions are garding some parts of their actions with a check on the variable `disabledEvents'. 
"
Class {
	#name : #MicDocumentBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'spButtonBar',
		'spDocumentList',
		'spRendering',
		'spSource',
		'saveButton',
		'documentRoots',
		'documentModel',
		'layoutModel',
		'disableEvents'
	],
	#classVars : [
		'Browser'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #'services menu' }
MicDocumentBrowser class >> fileReaderServicesForFile: fullName suffix: suffix [
	<fileService>
	suffix = 'md' ifFalse:[^ #() ].
	^ { self serviceOpenMicrodownDocument  }
]

{ #category : #'services menu' }
MicDocumentBrowser class >> itemsForDirectory: aFileDirectory [
	<directoryService>
	
	^ { self serviceOpenMicrodownDirectory }
]

{ #category : #'instance creation' }
MicDocumentBrowser class >> open [
	"I ensure the browser to be open. If no browser exist, I instantiate one"
	<script>
	Browser ifNil: [ Browser := self new ].
	(Browser owner isNil or: [ Browser owner isClosed ])
		ifTrue: [ Browser open ].
	
	
]

{ #category : #opening }
MicDocumentBrowser class >> openDocument: aMicResourceReferenceOrString [
	"I open microdown documents. If an existing browser instance is present, add the reference to the browser.
	I am called when following links in rich text to microdown documents, but can also be used as api method."
	
	<richtextlinkpresenter: #md>
	self open.
	Browser addRoot: (aMicResourceReferenceOrString isString
		ifTrue: [ aMicResourceReferenceOrString asMicResourceReference  ]
		ifFalse: [aMicResourceReferenceOrString ])
]

{ #category : #'services menu' }
MicDocumentBrowser class >> serviceOpenMicrodownDirectory [
	"Answer the service of opening a file-contents browser"

	^ (SimpleServiceEntry
		provider: self 
		label: 'Open Micodown document'
		selector: #openDocument:
		description: 'Open a this document in Microdown Document Browser'
		buttonLabel: 'Microdown')
		argumentGetter: [ :file| file fullName]
]

{ #category : #'services menu' }
MicDocumentBrowser class >> serviceOpenMicrodownDocument [
	"Answer the service of opening a file-contents browser"

	^ (SimpleServiceEntry
		provider: self 
		label: 'Open Micodown document'
		selector: #openDocument:
		description: 'Open a this document in Microdown Document Browser'
		buttonLabel: 'Microdown')
		argumentGetter: [ :file| file fullName]
]

{ #category : #navigation }
MicDocumentBrowser >> addRoot: document [
	"Add document to the documents list and select it. If already in the list, just select it"
	| toSelect |
	"Notice, once equals is defined for resource references this code should make use of it"
	toSelect := self documentRoots 
		detect: [ :root | root uri = document uri ] 
		ifNone: [self documentRoots add: document. document].
	self disableEventsDuring: [
		spDocumentList roots: self documentRoots.
		spDocumentList selection selectItem: toSelect].
	self documentSelected: document
		
	
	
]

{ #category : #navigation }
MicDocumentBrowser >> childrenOf: aNode [
	"I am a utility method to find children in a node"
	(aNode isKindOf: MicElement)
		ifTrue: [ ^ aNode subsections children].
	aNode loadChildren
		ifNotEmpty: [ :children |  ^ children sort: [:a :b | (self displayStringOf: a) < (self displayStringOf: b)] ]
		ifEmpty: [ 
			[ ^ self childrenOf: (MicSectionBlock fromRoot: aNode loadMicrodown) ] 
			on: Error  
			do: [ ^ #() ]]
	
]

{ #category : #initialization }
MicDocumentBrowser >> connectPresenters [
	"Listen to gui input"
	spDocumentList 
		whenSelectionChangedDo: [ :selection | self guiNewSelection: selection selectedItem ].
	spSource 
		whenSubmitDo: [:text|  self guiSaveSource ];
		whenTextChangedDo: [ :newSource | self guiSetSource: newSource ]
]

{ #category : #private }
MicDocumentBrowser >> defaultDocumentRoots [
	"By default include the pharo doc and the docs of loaded projects"
	^ ({'github://pharo-project/pharo/doc'}, 
		self loadedDocsInWorkspace  )
			collect: #asMicResourceReference
]

{ #category : #events }
MicDocumentBrowser >> disableEventsDuring: aBlock [
	| old | 
	"The clue of old is to allow multible nested diableEventsDuring calls
	and only the outermost will reset back to the default false value"
	old := disableEvents.
	disableEvents := true.
	aBlock value.
	disableEvents := old. 
]

{ #category : #navigation }
MicDocumentBrowser >> displayIconOf: aNode [
	"Utility method to put icons on the document list"
	(aNode isKindOf: MicElement) ifTrue: [ ^ self iconNamed: #smallLeftFlush ].
	^ aNode browserIcon
]

{ #category : #navigation }
MicDocumentBrowser >> displayStringOf: aNode [
	"Utility method to generate the titles used in document list"
	(aNode isKindOf: MicSectionBlock) ifTrue: [ ^ (Microdown asRichText: aNode header) asString trim ].
	^aNode browserTitle
]

{ #category : #private }
MicDocumentBrowser >> documentRoots [
	^ documentRoots 
		ifNil: [ documentRoots := self defaultDocumentRoots asOrderedCollection  ].
]

{ #category : #navigation }
MicDocumentBrowser >> documentSelected: document [
	"document is newly selected, and should be rendered. If source is showing, set it as well"
	documentModel save.
	documentModel resourceReference: document.
	documentModel resourceReference 
		ifNotNil: [ 
			spRendering document: documentModel document.
			layoutModel showSource 
				ifTrue: [ spSource text: documentModel source ].
			self owner title: (self displayStringOf: documentModel resourceReference )  ]
]

{ #category : #events }
MicDocumentBrowser >> guiNewSelection: selection [
	"I am called when a user selects a new element in spDocumentList"
	disableEvents ifTrue: [ ^ self ].
	self documentSelected: selection
]

{ #category : #events }
MicDocumentBrowser >> guiSaveSource [
	"called by save button or accept in spSource"
	| path sourceSelection sourceScroll |
	disableEvents ifTrue: [ ^ self ].
	documentModel isDirty ifFalse: [ ^ self ].
	self disableEventsDuring: [ 
		documentModel
			source: spSource text;
			save.
		spRendering document: documentModel document.
		"Sync the views"
		path := spDocumentList selection selectedPath.
		sourceSelection := spSource selectionInterval.
		sourceScroll := spSource adapter widget scrollPane vScrollbarValue.
		spDocumentList roots: self documentRoots.
		spDocumentList
			expandPath: path;
			selectPath: path.
		spSource selectionInterval: sourceSelection.
		spSource adapter setScrollValue: 0 @ sourceScroll.
		spRendering adapter setScrollValue: 0 @ sourceScroll.
		spSource takeKeyboardFocus ]
]

{ #category : #events }
MicDocumentBrowser >> guiSetListShowing: aBoolean [
	"Change layout to include the document list or not"
	layoutModel showDocumentList: aBoolean.
	self disableEventsDuring: [ self setTopLayout ] 
]

{ #category : #events }
MicDocumentBrowser >> guiSetSource: newSource [
	"called by changes to spSource"
	disableEvents ifTrue: [ ^ self ].
	documentModel source: newSource
	
]

{ #category : #events }
MicDocumentBrowser >> guiSetSourceMode: sourceMode [
	"Change the layout as how spRendering and spSource are placed"
	layoutModel sourceMode: sourceMode.
	self disableEventsDuring: [ self setTopLayout  ]
]

{ #category : #events }
MicDocumentBrowser >> guiSetSourceShowing: showSource [
	"change layout to include spSource or not"
	layoutModel showSource: showSource.
	self disableEventsDuring: 
		[ 	showSource ifTrue: [ spSource text: documentModel source ].
			self setTopLayout ]
]

{ #category : #initialization }
MicDocumentBrowser >> initialExtent [
	^ 1000@600
]

{ #category : #initialization }
MicDocumentBrowser >> initialize [
	"Initialize my models first"
	documentModel := MicDocumentBrowserModel new.
	layoutModel := MicDocumentBrowserLayoutModel new.
	disableEvents := false.
	super initialize
]

{ #category : #initialization }
MicDocumentBrowser >> initializeButtons [
	"initialize the button bar"
	spButtonBar := self instantiate: MicDocumentBrowserButtonBar.
	spButtonBar
		left: (spButtonBar newCheckBox
				 label: 'Show List';
				 state: layoutModel showDocumentList;
				 whenChangedDo: [ :val | self guiSetListShowing: val ]);
		right: (spButtonBar newDropList
				 help: 'source view';
				 items: layoutModel sourceModes;
				 whenSelectedItemChangedDo: [ :item | 
					 self guiSetSourceMode: item ]);
		right: (saveButton := spButtonBar newButton
				 label: 'Save';
				 state: layoutModel showSource;
				  action: [ self guiSaveSource ]);
		right: (spButtonBar newCheckBox
				 label: 'Show Source';
				 state: layoutModel showSource;
				 whenChangedDo: [ :val | self guiSetSourceShowing: val ])
]

{ #category : #initialization }
MicDocumentBrowser >> initializePresenters [

	super initializePresenters.
	
	Browser := self.
	spDocumentList := self newTree.
	spDocumentList
		roots: self documentRoots;
		children: [ :aNode | self childrenOf: aNode ];
		display: [ :aNode | self displayStringOf: aNode ];
		displayIcon: [ :aNode | self displayIconOf: aNode ].
	spRendering := self instantiate: MicrodownPresenter.
	spSource := self newText.
	self initializeButtons
]

{ #category : #initialization }
MicDocumentBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ 
		self saveSource.
		Browser := nil ].
]

{ #category : #layout }
MicDocumentBrowser >> layout [
	"I use dynamic layout"
	layout ifNil: [ self setTopLayout  ].
	^ layout 
]

{ #category : #private }
MicDocumentBrowser >> loadedDocsInWorkspace [
	"I return all the doc folders which exist in the local iceberg repository"
	| iceRepository githubUsers |
	iceRepository := FileSystem workingDirectory / 'pharo-local' / 'iceberg'.
	githubUsers := iceRepository directories.
	^ ((githubUsers collect: [ :userDir | userDir directories ]) flattened
		collect: [ :project | project directories ]) flattened
		select: [ :dir | #('doc' 'docs') includes: dir basename ]
]

{ #category : #layout }
MicDocumentBrowser >> setTopLayout [
	"I set the layout of the browser. The dynamic part of the layout is done by layoutModel"
	self layout: (SpBoxLayout newTopToBottom
		add: (layoutModel
			layoutList: spDocumentList
			rendering: spRendering
			source: spSource);
		add: spButtonBar expand: false;
		yourself)
]

{ #category : #initialization }
MicDocumentBrowser >> title [
	^ 'Microdown document browser'
]
