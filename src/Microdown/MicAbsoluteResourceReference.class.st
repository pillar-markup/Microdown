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
