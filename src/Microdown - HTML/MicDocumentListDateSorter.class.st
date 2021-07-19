Class {
	#name : #MicDocumentListDateSorter,
	#superclass : #MicDocumentListSorter,
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicDocumentListDateSorter >> initialize [
	super initialize.
	files := OrderedCollection new.
	direction := -1
]

{ #category : #sorting }
MicDocumentListDateSorter >> sort [
	^ files sort: [ :a :b | 
		direction < 0 ifTrue: [a modificationTime > b modificationTime ]
		ifFalse: [a modificationTime < b modificationTime]]
]
