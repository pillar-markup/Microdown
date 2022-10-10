"
[ documentModel source  ]
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
	#classVars : [
		'Browser'
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
MicDocumentBrowserModel >> resourceReference: refereceSectionOrNil [
	"I set the document and source of the argument"
	('Document model set reference: ', refereceSectionOrNil printString) traceCr.
	refereceSectionOrNil ifNil: [ 1halt].
	resourceReference := refereceSectionOrNil.
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
	('Document model source: ', (markupString truncateTo: 20)) traceCr.
	self canSave ifFalse: [ ^ Error signal: 'Cannot save to ', resourceReference uri ].
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
