Class {
	#name : #MicIntoDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #initialization }
MicIntoDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Into';
		description: 'Into tree'
]
