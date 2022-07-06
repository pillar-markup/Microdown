Class {
	#name : #MicCSSStylerExportCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #initialization }
MicCSSStylerExportCommand class >> defaultDescription [

	^ 'Export Microdown to HTML'
]

{ #category : #initialization }
MicCSSStylerExportCommand class >> defaultIconName [

	^ #smallExport
]

{ #category : #'accessing - defaults' }
MicCSSStylerExportCommand class >> defaultName [

	^ 'Export'
]

{ #category : #default }
MicCSSStylerExportCommand class >> defaultShortcutKey [

	^ $g command mac | $g ctrl win | $g ctrl unix
]

{ #category : #accessing }
MicCSSStylerExportCommand class >> order [

	^ 6
]

{ #category : #testing }
MicCSSStylerExportCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self context hasMicHtmlDocument ]
]

{ #category : #execution }
MicCSSStylerExportCommand >> execute [

	self canBeExecuted 
		ifFalse: [ ^ self inform: 'Please open a Microdown document first' ].
	self exportToHtml: self micHtmlDocument.
]
