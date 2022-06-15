"
I am a browser of collections of microdown documents.

I am work in progress, but reasonable functional.

I open by `MicDocumentBrowser class >> #open`.
Editing is done using the little edit flag in the lower right corner - there is currently no keyboard shortcut for this.
I can save some documents, but not all. I can save documents on files, and package/class comments. In particular I **cannot** save to github or the web. Saving is done on the save button when it is not greyed out.

I open with some documents being loaded, those are currently defined in `MicDocumentBrowser >>#documentRoots`. The plan is that an api should be added which will allow to manipulate this rootset, but at present experience and usage drives feature development.

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
		'isEditing',
		'sourceMode',
		'saveButton',
		'slideMode'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #commands }
MicDocumentBrowser class >> buildCommandsGroupWith: presenter forRoot: rootCommandGroup [
	rootCommandGroup register:
		(MicOpenDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		((MicIntoDocumentBrowserCommand forSpec) context: presenter).
	rootCommandGroup register:
		(MicUpDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		(MicNextDocumentBrowserCommand forSpec context: presenter).
	rootCommandGroup register:
		(MicPreviousDocumentBrowserCommand forSpec context: presenter)	
]

{ #category : #'instance creation' }
MicDocumentBrowser class >> open [
	<example>
	^ self new open
]

{ #category : #navigation }
MicDocumentBrowser >> childrenOf: aNode [
	|children|
	children := aNode loadChildren.
	^ children sort: [:a :b | (self displayStringOf: a) < (self displayStringOf: b)]
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

{ #category : #navigation }
MicDocumentBrowser >> displayIconOf: aNode [
	^ aNode browserIcon
]

{ #category : #navigation }
MicDocumentBrowser >> displayStringOf: aNode [
	^aNode browserTitle
]

{ #category : #private }
MicDocumentBrowser >> documentRoots [
	^ ({'comment://package/Microdown'.
		"'file:/Users/kasper/tmp/pharo/doc'."
		'github://pillar-markup/Microdown/doc/testMicrodown'
	 	}, 
		self loadedDocsInWorkspace  )
			collect: #asMicResourceReference
]

{ #category : #events }
MicDocumentBrowser >> documentSelected: document [
	"document is newly selected, and should be rendered. If source is needed, re-select to root document"
	self renderSection: document.
	self isEditing ifTrue: [ 
		self setSourceOfSelectedDocument  ]
]

{ #category : #initialization }
MicDocumentBrowser >> initialExtent [
	^ 1000@600
]

{ #category : #initialization }
MicDocumentBrowser >> initializeButtons [
	spButtonBar
		add: self slideToggleButton;
		add: (spButtonBar newDropList
			help: 'source view';
  			items: #( #Horizontal #Vertical #Swap);
  			whenSelectedItemChangedDo: [ :item | self sourceMode: item ]);
		add: (saveButton := spButtonBar newButton 
			label: 'Save';
			state: self isEditing;
			action: [ self saveNewSourceForSelectedDocument]);
		add: (spButtonBar newCheckBox
			label: 'Edit';
			state: self isEditing;
			whenChangedDo: [ :val | self setEditing: val ])
		
]

{ #category : #initialization }
MicDocumentBrowser >> initializePresenters [

	super initializePresenters.
	isEditing := false.
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

{ #category : #accessing }
MicDocumentBrowser >> isEditing [
	^ isEditing ifNil: [ isEditing := false ]

	
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
			^ self ].
	self documentSelected: selection
]

{ #category : #rendering }
MicDocumentBrowser >> renderSection: micReference [ 
	[ spRendering text:(Microdown asRichText: micReference loadMicrodown )]
	on: MicResourceReferenceError  
	do: [ spRendering text: '' ].
	spRendering selectionInterval: (1 to: 0)
	
]

{ #category : #'source code' }
MicDocumentBrowser >> saveNewSourceForSelectedDocument [
	"Selected document must be a root section"
	| docToSave|
	docToSave := spDocumentList selectedItem.
	spSource text = (docToSave contents) ifTrue: [ ^ self ].
	docToSave contents: spSource text.
	self renderSection: docToSave.
	self scrollSyncRenderToSource
	
	
]

{ #category : #'source code' }
MicDocumentBrowser >> scrollSyncRenderToSource [
	| sourceScroll str |
	str := spSource text asString.
	sourceScroll := (str lineNumberCorrespondingToIndex: (spSource selectionInterval first)) -1 /
		str lineCount.
	spRendering adapter widget scrollPane vScrollbarValue: sourceScroll
]

{ #category : #slides }
MicDocumentBrowser >> selectChildDocument [
	(MicIntoDocumentBrowserCommand forContext: self) execute
]

{ #category : #slides }
MicDocumentBrowser >> selectNextDocument [
	(MicNextDocumentBrowserCommand forContext: self) execute
]

{ #category : #slides }
MicDocumentBrowser >> selectParentDocument [
	(MicUpDocumentBrowserCommand forContext: self) execute
]

{ #category : #slides }
MicDocumentBrowser >> selectPreviousDocument [
	(MicPreviousDocumentBrowserCommand forContext: self) execute
]

{ #category : #layout }
MicDocumentBrowser >> setBrowserLayout [
	^SpBoxLayout newTopToBottom
		add: (SpPanedLayout newLeftToRight
					add: spDocumentList;
					add: self setDocumentlayout ;
					positionOfSlider: 0.3;
					yourself);
		add: spButtonBar expand: false;
		yourself
]

{ #category : #layout }
MicDocumentBrowser >> setDocumentlayout [

	"Depending on the state of EditDocument, show an editing pane in addition to document pane"

	| pane |
	self isEditing ifFalse: [ ^ spRendering ].
	self sourceMode = #Swap ifTrue: [ ^ spSource ].
	pane := self sourceMode = #Horizontal
		        ifTrue: [ SpPanedLayout newTopToBottom ]
		        ifFalse: [ SpPanedLayout newLeftToRight ].
	pane
		first: spRendering;
		second: spSource.
	^ pane
]

{ #category : #'source code' }
MicDocumentBrowser >> setEditStatus: status [
	"can be #canEdit, #connotEdit, #hasBeenEdited"
	status = #hasBeenEdited
		ifTrue: [ spSource color: self colorCanEdit. saveButton state: true. ^ self].
	status = #canEdit
		ifTrue: [ spSource color: self colorCanEdit. saveButton state: false. ^ self].
	status = #cannotEdit
		ifTrue: [ spSource color: self colorCannotEdit. saveButton state: false. ^ self]
		
]

{ #category : #accessing }
MicDocumentBrowser >> setEditing: aBoolean [
	isEditing := aBoolean.
	self setTopLayout.
	isEditing 
		ifTrue: [ self setSourceOfSelectedDocument ]
		ifFalse: [ self saveNewSourceForSelectedDocument ].

	
]

{ #category : #layout }
MicDocumentBrowser >> setSlideShowLayout [

	^ SpBoxLayout newVertical
		add: spRendering;
		add: (SpBoxLayout newHorizontal
			add: (SpButtonPresenter new
				iconName: #back;
				action: [ self selectPreviousDocument ];
				yourself);
			add: (SpButtonPresenter new
				iconName: #down;
				action: [ self selectChildDocument ];
				yourself);
			add: self slideToggleButton expand: false;
			add: (SpButtonPresenter new
				iconName: #up;
				action: [ self selectParentDocument ];
				yourself);
			add: (SpButtonPresenter new
				iconName: #forward;
				action: [ self selectNextDocument ];
				yourself);
			yourself) expand: false;
			yourself 
]

{ #category : #'source code' }
MicDocumentBrowser >> setSourceOfSelectedDocument [
	"I set the source of the selected document"
	| micRef original |
	micRef := spDocumentList selectedItem.
	original := micRef contents.
	spSource 
		text: original;
		editable: micRef canSave;
		whenTextChangedDo: [:text | saveButton state: text ~= original].
	micRef canSave
		ifTrue: [self setEditStatus: #canEdit]
		ifFalse: [self setEditStatus: #cannotEdit]
		
	
]

{ #category : #layout }
MicDocumentBrowser >> setTopLayout [

	self layout: (self slideMode 
		ifTrue:[ self setSlideShowLayout]
		ifFalse: [ self setBrowserLayout ] )
]

{ #category : #slides }
MicDocumentBrowser >> slideMode [
	^ slideMode state
]

{ #category : #slides }
MicDocumentBrowser >> slideToggleButton [
	slideMode ifNil: [ 
		slideMode := SpCheckBoxPresenter new.
		slideMode
			label: 'Slide mode';
			state: false; 
			whenChangedDo: [ :val | slideMode state: val. self setTopLayout  ];
			yourself].
	^ slideMode
]

{ #category : #'source code' }
MicDocumentBrowser >> sourceMode [
	^ sourceMode ifNil: [ sourceMode := #Horizontal ]
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
