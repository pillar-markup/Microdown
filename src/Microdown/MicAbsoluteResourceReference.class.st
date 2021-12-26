"
I represent a superclass for all absolute references.

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
MicAbsoluteResourceReference >> path [
	^ '/', self uri path
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
