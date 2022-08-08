"
I am a command to inspect currently selected document (good for debugging)
"
Class {
	#name : #MicInspectDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicInspectDocumentBrowserCommand >> execute [
	self context inspect.
	self context spDocumentList selectedItem inspect
]

{ #category : #initialization }
MicInspectDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Inspect reference';
		description: 'Inspects the selected document'
]
