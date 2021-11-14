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
