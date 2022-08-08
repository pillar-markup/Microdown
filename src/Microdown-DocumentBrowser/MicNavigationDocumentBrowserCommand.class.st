"
I am the superclass for navigation in the document hierarchy of the document browser
"
Class {
	#name : #MicNavigationDocumentBrowserCommand,
	#superclass : #MicDocumentBrowserCommand,
	#instVars : [
		'list',
		'path'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #initialization }
MicNavigationDocumentBrowserCommand >> context: aBrowser [
	super context: aBrowser.
	list := context spDocumentList.
	path := list  selection selectedPath.
	path isEmpty ifTrue: [ .
		list selectPath: (path := #(1))]
]

{ #category : #execution }
MicNavigationDocumentBrowserCommand >> execute [
	self subclassResponsibility 
]
