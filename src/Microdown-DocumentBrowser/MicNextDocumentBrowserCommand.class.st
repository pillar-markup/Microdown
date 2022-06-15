Class {
	#name : #MicNextDocumentBrowserCommand,
	#superclass : #MicNavigationDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicNextDocumentBrowserCommand >> execute [
	| next |
	next := path copy. 
	next at: next size put: next last + 1.
	list selectPath: next.
	list selection selectedItem ifNil: [ list selectPath: path ].
]

{ #category : #initialization }
MicNextDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Next';
		description: 'Move to next document'
]
