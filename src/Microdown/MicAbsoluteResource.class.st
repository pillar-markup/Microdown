"
I represent a superclass for all absolute references.

Common for all absolute references is that they store their reference in a uri (ZnUrl).
"
Class {
	#name : #MicAbsoluteResource,
	#superclass : #MicResourceReference,
	#instVars : [
		'uri'
	],
	#category : #'Microdown-Core'
}

{ #category : #testing }
MicAbsoluteResource >> isImage [

	^ self isImage: uri segments last
]

{ #category : #testing }
MicAbsoluteResource >> isResolved [ 
	^true
]

{ #category : #'accessing - resources' }
MicAbsoluteResource >> loadImage [
	"return an image form from my reference"
	self subclassResponsibility 
]

{ #category : #'accessing - resources' }
MicAbsoluteResource >> loadMicrodown [
	"load, parse and resolve a microdown document"
	self subclassResponsibility 
]

{ #category : #accessing }
MicAbsoluteResource >> path [
	^ '/', self uri path
]

{ #category : #accessing }
MicAbsoluteResource >> uri [

	^ uri
]

{ #category : #accessing }
MicAbsoluteResource >> uri: aZnUrl [
	uri := aZnUrl.
	originalString := uri printString 
]
