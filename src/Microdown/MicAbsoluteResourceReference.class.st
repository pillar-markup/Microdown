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

{ #category : #testing }
MicAbsoluteResourceReference >> isFileReference [
	^ false
]

{ #category : #loading }
MicAbsoluteResourceReference >> loadImage [
	^ ImageReadWriter formFromStream: self binaryReadStream
]

{ #category : #loading }
MicAbsoluteResourceReference >> loadMicrodown [
	"I am an absolute reference, so I should be able to load completely"
	|doc|
	doc := Microdown parse: self contents.
	MicZincPathResolver new
		absoluteReference: self;
		resolveDocument: doc.
	^ doc
]

{ #category : #accessing }
MicAbsoluteResourceReference >> path [
	"Answer a <String> with the receiver's relative URI without the scheme"

	^ String streamContents: [ : stream | 
		self uri printAuthorityOn: stream.
		self uri printPathQueryFragmentOn: stream ]
]

{ #category : #accessing }
MicAbsoluteResourceReference >> uri [

	^ uri
]

{ #category : #accessing }
MicAbsoluteResourceReference >> uri: aZnUrl [
	uri := aZnUrl.
	originalString := uri printString 
]
