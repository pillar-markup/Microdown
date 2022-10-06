"
I am a model used by the document browser.

I keep
- reference or section
- its source code
- its document in rendered format
"
Class {
	#name : #MicDocumentBrowserModel,
	#superclass : #SpPresenter,
	#instVars : [
		'resourceReference',
		'document',
		'source',
		'isDirty'
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
	resourceReference := refereceSectionOrNil.
	isDirty := false.
	refereceSectionOrNil 
		ifNil: [ source := document := nil ]
		ifNotNil: [ 
			document := refereceSectionOrNil loadMicrodown.
			source := refereceSectionOrNil contents.
	]
	
]

{ #category : #actions }
MicDocumentBrowserModel >> save [
	"store the source into resourceReference. Do nothing if not dirty or if not canSave"
	(isDirty and: [ self canSave ]) ifFalse: [ ^ self ].
	resourceReference contents: source.
	isDirty := false.
]

{ #category : #accessing }
MicDocumentBrowserModel >> source [

	^ source
]

{ #category : #accessing }
MicDocumentBrowserModel >> source: markupString [
	"Assumes we can save"
	self canSave ifFalse: [ ^ Error signal: 'A test is missing at my caller' ].
	source := markupString.
	isDirty := true.
]
