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

{ #category : #copying }
MicCSSFile >> copyTo: aDestinationDir [
	"Copy the receiver into aDestinationDir "

	[ self fileReference copyTo: aDestinationDir / self basename ]
	on: FileExists 
	do: [ : ex | "do nothing" ]
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
