Class {
	#name : #MicDocumentListNameSorter,
	#superclass : #MicDocumentListSorter,
	#category : #'Microdown - HTML'
}

{ #category : #initialization }
MicDocumentListNameSorter >> initialize [
	super initialize.
	files := OrderedCollection new.
	direction := 1
]

{ #category : #initialization }
MicDocumentListNameSorter >> sort [
	^ files sort: [ :a :b | 
		direction > 0 ifTrue: [a basename < b basename ]
		ifFalse: [a basename > b basename]]
]
