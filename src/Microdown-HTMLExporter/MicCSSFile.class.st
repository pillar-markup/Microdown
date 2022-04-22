Class {
	#name : #MicCSSFile,
	#superclass : #Object,
	#instVars : [
		'fileReference'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicCSSFile >> basename [

	^ self fileReference basename
]

{ #category : #accessing }
MicCSSFile >> fileReference [

	^ fileReference
]

{ #category : #accessing }
MicCSSFile >> fileReference: anObject [

	fileReference := anObject
]

{ #category : #accessing }
MicCSSFile >> fullName [
	"Answer a <String> with the full path of the receiver"

	^ self fileReference fullName
]

{ #category : #accessing }
MicCSSFile >> relativePath [
	"Answer a <String> representing the relative path to the receiver"

	^ self fileReference path fullName
]
