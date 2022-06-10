Class {
	#name : #MicPreviousDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #executing }
MicPreviousDocumentBrowserCommand >> execute [
	|list path next|
	list := context spDocumentList.
	path := list  selection selectedPath.
	next := path copy. 
	next at: next size put: next last - 1.
	list selectPath: next.
	list selection selectedItem ifNil: [ list selectPath: path ].
]

{ #category : #initialization }
MicPreviousDocumentBrowserCommand >> initialize [

	super initialize.
	self
		name: 'Previous';
		description: 'Move to previus document'
]
