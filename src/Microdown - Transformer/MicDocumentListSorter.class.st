Class {
	#name : #MicDocumentListSorter,
	#superclass : #Object,
	#instVars : [
		'direction',
		'files'
	],
	#category : #'Microdown - Transformer'
}

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
