Class {
	#name : #MicOpenDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicOpenDocumentBrowserCommand >> execute [
	"to be done"
	self context spDocumentList selectedItem inspect
]

{ #category : #initialization }
MicOpenDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Open reference';
		description: 'Opens the reference externally'
]
