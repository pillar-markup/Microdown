"
I maintain the state of the variable part of the document browser layout. In particular:
- showDocumentList - true by default - show the document list to the left in a paned layout
- showSource - boolean if the source panel should be shown
- sourceMode - one of the modes in `MicDocumentBrowserLayoutModel>>#sourceModes`

the document browser ask for a layout using the method: `MicDocumentBrowserLayoutModel>>layoutList:rendering:source`, which I compose based on my state
"
Class {
	#name : #MicDocumentBrowserLayoutModel,
	#superclass : #Model,
	#instVars : [
		'showDocumentList',
		'showSource',
		'sourceMode',
		'sourceLayouts'
	],
	#classVars : [
		'Browser'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #initialization }
MicDocumentBrowserLayoutModel >> initialize [
	showDocumentList := true.
	showSource := false.
	sourceMode := self sourceBotton.
	
]

{ #category : #layouting }
MicDocumentBrowserLayoutModel >> layoutList: spDocumentList rendering: spRendering source: spSource [
	"I return a layout based on my state for the three components"
	^ showDocumentList
		ifTrue: [ 
			SpPanedLayout newLeftToRight
				  add: spDocumentList;
				  add: (self layoutRendering: spRendering source: spSource );
				  positionOfSlider: 0.3;
				  yourself ]
		ifFalse: [ 
			self layoutRendering: spRendering source: spSource  ]
]

{ #category : #layouting }
MicDocumentBrowserLayoutModel >> layoutRendering: spRendering source: spSource [
	
	self showSource ifFalse: [ ^ spRendering ].
	self sourceMode = self sourceSwap ifTrue: [ ^ spSource ].
	^ (self sourceLayouts at: self sourceMode)
		value: spRendering
		value: spSource 
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> showDocumentList [

	^ showDocumentList
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> showDocumentList: anObject [

	showDocumentList := anObject
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> showSource [

	^ showSource
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> showSource: anObject [

	showSource := anObject
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceBotton [
	^'Source bottom'
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceLayouts [
	"return a dictionary of layout blocks."
	sourceLayouts ifNotNil: [ ^ sourceLayouts ].
	^ sourceLayouts := {
	self sourceBotton 	-> [ :r :s | SpPanedLayout newTopToBottom add: r;add: s; yourself].
	self sourceTop 		-> [ :r :s | SpPanedLayout newTopToBottom add: s;add: r; yourself].
	self sourceRight 	-> [ :r :s | SpPanedLayout newLeftToRight add: r;add: s; yourself].
	self sourceLeft		-> [ :r :s | SpPanedLayout newLeftToRight add: s;add: r; yourself].
	self sourceSwap 	-> [ :r :s | s ]
	} asDictionary 
	
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceLeft [
	^   'Source left'
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> sourceMode [

	^ sourceMode
]

{ #category : #accessing }
MicDocumentBrowserLayoutModel >> sourceMode: anObject [

	sourceMode := anObject
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceModes [

	^ self sourceLayouts keys
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceRight [
	^  'Source right'
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceSwap [
	^ #Swap 
]

{ #category : #'source modes' }
MicDocumentBrowserLayoutModel >> sourceTop [
	^ 'Source top'
]
