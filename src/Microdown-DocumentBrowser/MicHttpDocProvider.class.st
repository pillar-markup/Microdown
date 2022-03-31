Class {
	#name : #MicHttpDocProvider,
	#superclass : #MicAbstractDocProvider,
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #public }
MicHttpDocProvider >> displayString [
	^ 'Sofus'
]

{ #category : #accessing }
MicHttpDocProvider >> icon [
	^ self iconNamed: #book
]

{ #category : #public }
MicHttpDocProvider >> loadDocuments [
	"load and resolve the document at file path"
	| doc ref|
	ref := MicResourceReference fromUri: docUri printString.
	doc := ref loadMicrodown.
	doc := (MicSectionBlock fromRoot: doc header: docUri printString)
		documentUrl: doc
		yourself.
	^ MicDocumentCollection new
		title: docUri asString;
		children: {doc};
		parent: self.
]

{ #category : #public }
MicHttpDocProvider >> subLevels [
	^ {self documents}
]
