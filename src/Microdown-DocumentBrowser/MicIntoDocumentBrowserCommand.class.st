Class {
	#name : #MicIntoDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicIntoDocumentBrowserCommand >> execute [
	|list path|
	list := context spDocumentList.
	path := list  selection selectedPath.
	list selectPath: path, #(1).
	list selection selectedItem ifNil: [ list selectPath: path ].
]

{ #category : #initialization }
MicIntoDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Into';
		description: 'Into tree'
]
