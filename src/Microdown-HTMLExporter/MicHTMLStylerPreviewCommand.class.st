"
Command to export the Microdown document to HTML and open a web browser to preview the results.
"
Class {
	#name : #MicHTMLStylerPreviewCommand,
	#superclass : #MicHTMLStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #default }
MicHTMLStylerPreviewCommand class >> defaultDescription [

	^ 'Preview the selected style'
]

{ #category : #initialization }
MicHTMLStylerPreviewCommand class >> defaultIconName [

	^ #forward
]

{ #category : #default }
MicHTMLStylerPreviewCommand class >> defaultName [

	^ 'Preview'
]

{ #category : #default }
MicHTMLStylerPreviewCommand class >> defaultShortcutKey [

	^ $v command mac | $v ctrl win | $v ctrl unix
]

{ #category : #accessing }
MicHTMLStylerPreviewCommand class >> order [

	^ 3
]

{ #category : #testing }
MicHTMLStylerPreviewCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self context hasMicHtmlDocument ]
]

{ #category : #executing }
MicHTMLStylerPreviewCommand >> execute [

	self canBeExecuted 
		ifFalse: [ ^ self inform: 'Please open a Microdown document first' ].

	self exportToHtml: self micHtmlDocument.
	WebBrowser openOn: self micHtmlDocument fullName.
]
