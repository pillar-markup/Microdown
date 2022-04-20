"
I am a browser of collections of microdown documents.
I obtain my documents through DocProviders (through their `loadDocuments` method).

My overall architecture is based on these transitions:

![statediagram](https://www.planttext.com/api/plantuml/png/XPHDQzj048Rl-XNJ70kYj4SHtD2eq1uIIXToCJu8QL8jbZHYTorXIlvxPqUol2ivz6JxdMU-P_rWNM7SgMqIUzHTNvYY1LiN5Osw-mElHMCniBJKKLaRQX6SEM7Yj6iGddHfY3qwoAayjTWv-6Pej6YI163_yG3f3fwfGuKDbWuhLZcjGxZpAbpaEoXin476jN0WS3L2RsZG5HhhAKSzD3XWOuDOECwXD7LJB0NtzsLDkiJTBhcIZzJsPBLRfNvKd13Rtft1OCUfU0HNfwMto2TNJ4GrfxvP7ycAuiqAqdr5Zgq7DagQVNcfuR0bSY6gEQ47s6SRDz-A_o_tBoC07NdcvmjOEfaIdwZ2QMAVnRp_8JjJVQFTYyPHn3cm6eiU1XR5mV_o14I8zmkOACpY4IRm7VZl4x6e7hdWJF1N0T8qRaBRxvLslAsfXozXBS_av8ZyEK_DpcVcrAGg4QFojtZ4mZJ3guSg1ZdgKCkrSUT5cnz130goo1aVtO36mIVuC9tVkw3bZnkOM3qcV0P7FFyoQEqQy4yrk3QkRPrfIsGyXIEyaf7amh-5ft9pdl7KRb2yr9hVjC0Rc-zt1Vj5XXSmZ_Mtp66v-0o2mSmxdH2ul2bPQkmcz2hIyYZNEJBu6kJmatXBaWTM-9_q7m00)
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
		'saveButton'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #'instance creation' }
MicDocumentBrowser class >> open [
	<example>
	^ self new open
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

{ #category : #accessing }
MicDocumentBrowser >> documentList [
	^ spDocumentList
]

{ #category : #private }
MicDocumentBrowser >> documentRoots [
	^ {'comment://package/Microdown'.
		'file:///Users/kasper/tmp/pharo/doc' .
	 } collect: #asMicResourceReference
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
		children: [ :aNode | aNode loadChildren sort: [:a :b |a browserTitle < b browserTitle] ];
		display: [ :aNode | aNode browserTitle ];
		displayIcon: [ :aNode | aNode browserIcon ].

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

{ #category : #events }
MicDocumentBrowser >> newSelection: selection [
	"I am the raw user selection in the spDocumentList"
	selection isNil
		ifTrue: [ 
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
	self setEditStatus:  #canEdit
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
	self setTopLayout  
	isEditing 
		ifTrue: [ self setSourceOfSelectedDocument ]
		ifFalse: [ self saveNewSourceForSelectedDocument ].

	
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
	| newLayout |
	newLayout := SpBoxLayout newTopToBottom
			add: (SpPanedLayout newLeftToRight
				add: spDocumentList;
				add: self setDocumentlayout ;
				positionOfSlider: 0.3;
				yourself);
			add: spButtonBar expand: false;
			yourself.
	self layout: newLayout 
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

{ #category : #initialization }
MicDocumentBrowser >> title [
	^ 'Microdown document browser'
]
