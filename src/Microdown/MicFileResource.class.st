Class {
	#name : #MicFileResource,
	#superclass : #MicAbstractResource,
	#instVars : [
		'fileReference'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicFileResource class >> on: fileReference reference: aReference [

	^ self new
		fileReference: fileReference;
		reference: aReference;
		yourself
]

{ #category : #accessing }
MicFileResource >> contents [
	
	^ fileReference contents
]

{ #category : #accessing }
MicFileResource >> fileReference [

	^ fileReference
]

{ #category : #accessing }
MicFileResource >> fileReference: anObject [

	fileReference := anObject
]
