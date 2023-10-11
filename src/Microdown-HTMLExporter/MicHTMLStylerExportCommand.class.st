"
A command to write the Microdown input file as HTML.

"
Class {
	#name : 'MicHTMLStylerExportCommand',
	#superclass : 'MicHTMLStylerCommand',
	#category : 'Microdown-HTMLExporter-Spec-Commands',
	#package : 'Microdown-HTMLExporter',
	#tag : 'Spec-Commands'
}

{ #category : 'default' }
MicHTMLStylerExportCommand class >> defaultDescription [

	^ 'Export Microdown to HTML'
]

{ #category : 'initialization' }
MicHTMLStylerExportCommand class >> defaultIconName [

	^ #smallExport
]

{ #category : 'default' }
MicHTMLStylerExportCommand class >> defaultName [

	^ 'Export'
]

{ #category : 'default' }
MicHTMLStylerExportCommand class >> defaultShortcutKey [

	^ $g command mac | $g ctrl win | $g ctrl unix
]

{ #category : 'accessing' }
MicHTMLStylerExportCommand class >> order [

	^ 6
]

{ #category : 'testing' }
MicHTMLStylerExportCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self context hasMicHtmlDocument ]
]

{ #category : 'executing' }
MicHTMLStylerExportCommand >> execute [

	self canBeExecuted 
		ifFalse: [ ^ self inform: 'Please open a Microdown document first' ].
	self exportToHtml: self micHtmlDocument.
]
