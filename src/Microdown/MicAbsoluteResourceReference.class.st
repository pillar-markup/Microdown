"
I represent a superclass for all absolute references.
A reference will then be resolved and produces a resource.

Common for all absolute references is that they store their reference in a uri (ZnUrl).
"
Class {
	#name : #MicAbsoluteResourceReference,
	#superclass : #MicResourceReference,
	#instVars : [
		'uri'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicAbsoluteResourceReference >> binaryReadStream [
	"return the binaryStream I refer to"
	self subclassResponsibility.
]

{ #category : #testing }
MicAbsoluteResourceReference >> canSave [
	"return true if I implement contents: "
	^false
]

{ #category : #accessing }
MicAbsoluteResourceReference >> contents [
	"return the contents I refer to"
	self subclassResponsibility.
]

{ #category : #accessing }
MicAbsoluteResourceReference >> contents: aString [
	"Some of my subclasses can be written to. By default you cannot, and I then give an error"
	MicResourceReferenceError signal: self printString, ' can not be given new contents'
]

{ #category : #testing }
MicAbsoluteResourceReference >> isFileReference [
	^ false
]

{ #category : #accessing }
MicAbsoluteResourceReference >> loadChildren [
	"return a collection of absolute child references"
	^#()
]

{ #category : #loading }
MicAbsoluteResourceReference >> loadImage [
	^ ImageReadWriter formFromStream: self binaryReadStream
]

{ #category : #loading }
MicAbsoluteResourceReference >> loadMicrodown [
	"I am an absolute reference, so I can load completely"
	| doc| 
	doc := Microdown parse: self contents.
		MicZincPathResolver new
			absoluteReference: self;
			resolveDocument: doc.
	^ doc
]

{ #category : #accessing }
MicAbsoluteResourceReference >> path [
	"return the path part of my uri"
	^ '/',uri path
]

{ #category : #printing }
MicAbsoluteResourceReference >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: self uriString;
		nextPutAll: ')'
]

{ #category : #accessing }
MicAbsoluteResourceReference >> uri [

	^ uri
]

{ #category : #accessing }
MicAbsoluteResourceReference >> uri: aZnUrl [
	uri := aZnUrl
]

{ #category : #accessing }
MicAbsoluteResourceReference >> uriString [
	^ uri printString
]
