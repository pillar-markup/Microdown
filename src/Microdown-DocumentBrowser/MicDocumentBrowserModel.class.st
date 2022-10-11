"
I am a model used by the document browser.

I keep
- reference or section
- its source code
- its document in rendered format
- isDirty indicated if the source has not been saved

Setting the resourceReference renders updates the source and document
"
Class {
	#name : #MicDocumentBrowserModel,
	#superclass : #Model,
	#instVars : [
		'document',
		'source',
		'isDirty',
		'resourceReference'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #accessing }
MicDocumentBrowserModel >> canSave [
	resourceReference ifNil: [ ^ false ].
	^ resourceReference canSave
]

{ #category : #accessing }
MicDocumentBrowserModel >> document [

	^ document
]

{ #category : #initialization }
MicDocumentBrowserModel >> initialize [
	isDirty := false.
]

{ #category : #accessing }
MicDocumentBrowserModel >> isDirty [

	^ isDirty
]

{ #category : #accessing }
MicDocumentBrowserModel >> resourceReference [

	^ resourceReference
]

{ #category : #accessing }
MicDocumentBrowserModel >> resourceReference: ref [
	"I set the document and source of the argument"
	resourceReference := ref.
	isDirty := false.
	self updateDocumentFromSource
	
]

{ #category : #actions }
MicDocumentBrowserModel >> save [
	"store the source into resourceReference. Do nothing if not dirty or if not canSave"
	(isDirty and: [ self canSave ]) ifFalse: [ ^ self ].
	resourceReference contents: source.
	self updateDocumentFromSource.
	isDirty := false.
]

{ #category : #accessing }
MicDocumentBrowserModel >> source [

	^ source
]

{ #category : #accessing }
MicDocumentBrowserModel >> source: markupString [
	"Assumes we can save"
	self canSave ifFalse: [ ^ self ].
	source := markupString.
	isDirty := true.
]

{ #category : #accessing }
MicDocumentBrowserModel >> updateDocumentFromSource [

	resourceReference ifNil: [ ^ source := document := nil ].
	[ 
	document := resourceReference loadMicrodown.
	source := resourceReference contents ]
		on: MicResourceReferenceError
		do: [ :error | 
			document := Microdown parse: '# Error: ' , error message.
			source := '# Resorce error' ].
]
