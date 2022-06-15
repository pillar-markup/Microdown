Class {
	#name : #MicUpDocumentBrowserCommand,
	#superclass : #MicNavigationDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicUpDocumentBrowserCommand >> execute [
	path size <= 1 ifTrue: [ ^self ].
	list selectPath: path allButLast.
	list selection selectedItem ifNil: [ list selectPath: path ].
]

{ #category : #initialization }
MicUpDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Up';
		description: 'Up in the tree'
]
