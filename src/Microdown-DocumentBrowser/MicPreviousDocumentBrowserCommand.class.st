Class {
	#name : #MicPreviousDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #initialization }
MicPreviousDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Previous';
		description: 'Move to previus document'
]
