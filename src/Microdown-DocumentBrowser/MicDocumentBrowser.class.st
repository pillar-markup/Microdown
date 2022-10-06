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


"
Class {
	#name : #MicDocumentBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'spDocumentList',
		'spButtonBar',
		'spRendering',
		'spSource',
		'sourceMode',
		'saveButton',
		'isSourceShowing',
		'textComposer',
		'documentRoots',
		'currentReference',
		'browserModel'
	],
	#classVars : [
		'Browser'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #commands }
MicDocumentBrowser class >> buildCommandsGroupWith: presenter forRoot: rootCommandGroup [
	rootCommandGroup register:
		(MicInspectDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		((MicIntoDocumentBrowserCommand forSpec) context: presenter).
	rootCommandGroup register:
		(MicUpDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		(MicNextDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		(MicPreviousDocumentBrowserCommand forSpec context: presenter)	
]

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
	<example>
	Browser := nil.
	^ self new open
]

{ #category : #opening }
MicDocumentBrowser class >> openDocument: aMicResourceReferenceOrString [
	"I open microdown documents. If an existing browser instance is present, add the reference to the browser.
	I am called when following links in rich text to microdown documents, but can also be used as api method."
	<richtextlinkpresenter: #md>
	Browser ifNil: [ self new open ].
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

{ #category : #accessing }
MicDocumentBrowser >> addRoot: document [
	(self documentRoots includes: document)
		ifFalse: [ 
			self documentRoots add: document.
			self setTopLayout ]. 
	self spDocumentList selection selectItem: document.
	self documentSelected: document
		
	
	
]

{ #category : #rendering }
MicDocumentBrowser >> asRichText: doc [
	"reuse composer with its existing textStyler"
	textComposer ifNil: [ textComposer := MicRichTextComposer new ].
	
	^ textComposer asRichText: doc
]

{ #category : #navigation }
MicDocumentBrowser >> childrenOf: aNode [
	(aNode isKindOf: MicElement)
		ifTrue: [ ^ aNode subsections children].
	aNode loadChildren
		ifNotEmpty: [ :children |  ^ children sort: [:a :b | (self displayStringOf: a) < (self displayStringOf: b)] ]
		ifEmpty: [ 
			[ ^ self childrenOf: (MicSectionBlock fromRoot: aNode loadMicrodown) ] 
			on: Error  
			do: [ ^ #() ]]
	
]

{ #category : #'source code' }
MicDocumentBrowser >> colorCanEdit [
	^ self theme backgroundColor 
]

{ #category : #'source code' }
MicDocumentBrowser >> colorCannotEdit [
	| bgColor |
	bgColor := self theme backgroundColor.
	^ bgColor lightness < 0.5
		ifTrue: [ bgColor + (Color r: 0.0 g: 0.04 b:0.08 )]
		ifFalse: [ bgColor darker ]
]

{ #category : #initialization }
MicDocumentBrowser >> connectPresenters [
 
	spDocumentList
		whenSelectionChangedDo: [ :selection | self newSelection: selection selectedItem ].
	spSource whenSubmitDo:  [ :newText | self saveNewSourceForSelectedDocument  ]
	
]

{ #category : #private }
MicDocumentBrowser >> defaultDocumentRoots [
	^ ({'comment://package/Microdown-DocumentBrowser'.
		"'file:/Users/kasper/tmp/pharo/doc'."
		'github://pharo-project/pharo:Pharo11/doc/Regex'
	 	}, 
		self loadedDocsInWorkspace  )
			collect: #asMicResourceReference
]

{ #category : #navigation }
MicDocumentBrowser >> displayIconOf: aNode [
	(aNode isKindOf: MicElement) ifTrue: [ ^ self iconNamed: #smallLeftFlush ].
	^ aNode browserIcon
]

{ #category : #navigation }
MicDocumentBrowser >> displayStringOf: aNode [
	(aNode isKindOf: MicSectionBlock) ifTrue: [ ^ (Microdown asRichText: aNode header) asString trim ].
	^aNode browserTitle
]

{ #category : #private }
MicDocumentBrowser >> documentRoots [
	^ documentRoots ifNil: [ documentRoots := self defaultDocumentRoots asOrderedCollection  ].
]

{ #category : #events }
MicDocumentBrowser >> documentSelected: document [
	"document is newly selected, and should be rendered. If source is needed, set it as well"
	(document ~= currentReference and: [self isCurrentDirty]) 
		ifTrue: [ currentReference contents: spSource text  ].
	currentReference := document.
	self renderDocument: document.
	self isSourceShowing ifTrue: [ 
		self setSourceOfSelectedDocument  ]
]

{ #category : #initialization }
MicDocumentBrowser >> initialExtent [
	^ 1000@600
]

{ #category : #initialization }
MicDocumentBrowser >> initializeButtons [
	spButtonBar
		add: (spButtonBar newDropList
			help: 'source view';
  			items: #( 'Source bottom' 'Source top' 'Source right' 'Source left' #Swap );
  			whenSelectedItemChangedDo: [ :item | self sourceMode: item ]);
		add: (saveButton := spButtonBar newButton 
			label: 'Save';
			state: self isSourceShowing;
			action: [ self saveNewSourceForSelectedDocument]);
		add: (spButtonBar newCheckBox
			label: 'Show Source';
			state: self isSourceShowing;
			whenChangedDo: [ :val | self setSourceShowing: val ])
		
]

{ #category : #initialization }
MicDocumentBrowser >> initializePresenters [

	super initializePresenters.
	Browser := self.
	isSourceShowing := false.
	spDocumentList := self newTree.
	spDocumentList 
		roots: self documentRoots ;
		children: [ :aNode | self childrenOf: aNode ];
		display: [ :aNode | self displayStringOf: aNode ];
		displayIcon: [ :aNode | self displayIconOf: aNode ].
	spDocumentList contextMenu: [ self rootCommandsGroup beRoot asMenuPresenter].

	spRendering := self instantiate: MicrodownPresenter.
	spSource := self newText.
	spButtonBar := self newButtonBar.
	self initializeButtons.
	self setTopLayout




]

{ #category : #initialization }
MicDocumentBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ Browser := nil ].
]

{ #category : #testing }
MicDocumentBrowser >> isCurrentDirty [
	currentReference ifNil: [ ^ false ].
	currentReference canSave ifFalse: [ ^ false ].
	^ spSource text ~= currentReference contents
]

{ #category : #accessing }
MicDocumentBrowser >> isSourceShowing [
	^ isSourceShowing ifNil: [ isSourceShowing := false ]

	
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

{ #category : #events }
MicDocumentBrowser >> newSelection: selection [
	"I am the raw user selection in the spDocumentList"
	selection ifNil: [ 
			spRendering text: '' asText.
			spSource text: ''.
			currentReference := nil.
			^ self ].
	self documentSelected: selection
]

{ #category : #rendering }
MicDocumentBrowser >> renderDocument: referenceOrSection [ 
	|doc|
	[ doc := (referenceOrSection isKindOf: MicElement )
		ifTrue: [  "should reuse composer when selecting section" 
			referenceOrSection] 
		ifFalse: [ 
			textComposer := nil. "If selecting a new root, reset composer"
			referenceOrSection loadMicrodown ].
	  spRendering text:(self asRichText: doc )]
	on: MicResourceReferenceError  
	do: [ spRendering text: '' ].
	spRendering selectionInterval: (1 to: 0)
	
]

{ #category : #'source code' }
MicDocumentBrowser >> saveNewSourceForSelectedDocument [
	"Selected document must be a root section"
	| path sourceSelection sourceScroll|
	currentReference ifNil: [ ^ self ].
	self isCurrentDirty ifFalse: [ ^ self ].
	currentReference contents: spSource text.
	self renderDocument: currentReference.
	"Sync the views"
	path := spDocumentList selection selectedPath.
	sourceSelection := spSource selectionInterval.
	sourceScroll := spSource adapter widget scrollPane vScrollbarValue.
	spDocumentList roots: self documentRoots .
	spDocumentList 
		expandPath: path;
		selectPath: path.
	spSource selectionInterval: sourceSelection.
	spSource adapter setScrollValue: 0 @ sourceScroll.
	spRendering adapter setScrollValue: 0 @ sourceScroll.
	spSource takeKeyboardFocus.
	
	
	
	
	
]

{ #category : #'source code' }
MicDocumentBrowser >> scrollSyncRenderToSource [
	| sourceScroll str |
	str := spSource text asString.
	sourceScroll := (str lineNumberCorrespondingToIndex: (spSource selectionInterval first)) -1 /
		str lineCount.
	spRendering adapter widget scrollPane vScrollbarValue: sourceScroll
]

{ #category : #layout }
MicDocumentBrowser >> setDocumentlayout [

	"Depending on the state of EditDocument, show an editing pane in addition to document pane"

	| pane |
	self isSourceShowing ifFalse: [ ^ spRendering ].
	"#source modes are: #( 'Source bottom' 'Source top' 'Source right' 'Source left' #Swap )"
	self sourceMode = #Swap ifTrue: [ ^ spSource ].
	pane := (#('Source top' 'Source bottom') includes: self sourceMode)
		        ifTrue: [ SpPanedLayout newTopToBottom ]
		        ifFalse: [ SpPanedLayout newLeftToRight ].
	(#('Source left' 'Source top') includes: self sourceMode)
		ifTrue: [ pane first: spSource; second: spRendering ]
		ifFalse: [ pane first: spRendering; second: spSource].
	^ pane
]

{ #category : #'source code' }
MicDocumentBrowser >> setEditStatus: status [
	"can be #canEdit, #connotEdit, #hasBeenEdited"
	status = #hasBeenEdited
		ifTrue: [ spSource adapter widget color: self colorCanEdit. saveButton state: true. ^ self].
	status = #canEdit
		ifTrue: [ spSource adapter widget color: self colorCanEdit. saveButton state: false. ^ self].
	status = #cannotEdit
		ifTrue: [ spSource adapter widget color: self colorCannotEdit. saveButton state: false. ^ self]
		
]

{ #category : #'source code' }
MicDocumentBrowser >> setSourceOfSelectedDocument [
	"I set the source of the selected document"
	| original |
	currentReference := spDocumentList selectedItem.
	currentReference ifNil: [ ^ self ].
	original := currentReference contents.
	spSource 
		text: original;
		editable: currentReference canSave;
		whenTextChangedDo: [:text | saveButton state: text ~= original].
	currentReference canSave
		ifTrue: [self setEditStatus: #canEdit]
		ifFalse: [self setEditStatus: #cannotEdit]
		
	
]

{ #category : #accessing }
MicDocumentBrowser >> setSourceShowing: aBoolean [
	isSourceShowing := aBoolean.
	self setTopLayout.
	isSourceShowing 
		ifTrue: [ self setSourceOfSelectedDocument ]
		ifFalse: [ self saveNewSourceForSelectedDocument ].

	
]

{ #category : #layout }
MicDocumentBrowser >> setTopLayout [
	self layout: ( SpBoxLayout newTopToBottom
		add: (SpPanedLayout newLeftToRight
					add: spDocumentList;
					add: self setDocumentlayout ;
					positionOfSlider: 0.3;
					yourself);
		add: spButtonBar expand: false;
		yourself)
]

{ #category : #'source code' }
MicDocumentBrowser >> sourceMode [
	^ sourceMode ifNil: [ sourceMode := 'Source bottom' ]
]

{ #category : #'source code' }
MicDocumentBrowser >> sourceMode: mode [

	sourceMode := mode.
	self setTopLayout. 
]

{ #category : #accessing }
MicDocumentBrowser >> spDocumentList [

	^ spDocumentList
]

{ #category : #accessing }
MicDocumentBrowser >> spRendering [

	^ spRendering
]

{ #category : #accessing }
MicDocumentBrowser >> spSource [

	^ spSource
]

{ #category : #initialization }
MicDocumentBrowser >> title [
	^ 'Microdown document browser'
]
