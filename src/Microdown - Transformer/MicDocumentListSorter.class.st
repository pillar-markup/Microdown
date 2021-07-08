Class {
	#name : #MicDocumentListSorter,
	#superclass : #Object,
	#instVars : [
		'direction',
		'files'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #'instance creation' }
MicDocumentListSorter class >> with: aCollection [
	^ self new
		files: aCollection;
		sort
]

{ #category : #'instance creation' }
MicDocumentListSorter class >> with: aCollection order: aString [
	^ self new
		files: aCollection;
		direction: aString;
		sort
]

{ #category : #accessing }
MicDocumentListSorter >> direction [
	^ direction
]

{ #category : #accessing }
MicDocumentListSorter >> files [
	^ files
]

{ #category : #accessing }
MicDocumentListSorter >> files: anObject [
	files := anObject
]

{ #category : #accessing }
MicDocumentListSorter >> sort [
	^ self subclassResponsibility 
]
