"
It includes behavior to facilitate the handling of CSS files, such as relative paths, copying to other folders, etc.
"
Class {
	#name : #MicCSSFile,
	#superclass : #Object,
	#instVars : [
		'fileReference'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSFile >> basename [

	^ self fileReference basename
]

{ #category : #copying }
MicCSSFile >> copyTo: aFileReference [
	"Copy the receiver into aFileReference, if the file already exists, notify, delete it and retry"

	[ self fileReference copyTo: aFileReference ]
	on: FileExists 
	do: [ : ex | 
		ex printString traceCr.
		(aFileReference / self basename) ensureDelete.
		ex retry. ]
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
