"
I represent the way to produce an output document (LaTex,....)
I often compose a visitor and some unix scripts + some folders for storing resources.
"
Class {
	#name : #MicAbstractOutputDocumentMaker,
	#superclass : #Object,
	#instVars : [
		'baseDirectory'
	],
	#category : #'Microdown-Templated'
}

{ #category : #accessing }
MicAbstractOutputDocumentMaker >> baseDirectory [

	^ baseDirectory
]

{ #category : #accessing }
MicAbstractOutputDocumentMaker >> baseDirectory: anObject [

	baseDirectory := anObject
]

{ #category : #accessing }
MicAbstractOutputDocumentMaker >> basicWriter [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
MicAbstractOutputDocumentMaker >> templateDirectory [

	^ self baseDirectory / '_support' / 'templates' / self writer folderName
]

{ #category : #accessing }
MicAbstractOutputDocumentMaker >> writer [

	| writer |
	writer := self basicWriter.
	writer := PRTemplatedWriter new
			outputDocument: self;
			defaultWriter: writer;
			yourself .
	^ writer
]
