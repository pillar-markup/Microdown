Class {
	#name : #MicHTTPResource,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicHTTPResource >> asFileReference [

	^ urlOrFileReference asFileReference
]

{ #category : #converting }
MicHTTPResource >> fullName [

	^ urlOrFileReference printString
]

{ #category : #querying }
MicHTTPResource >> query [
	^ urlOrFileReference query
]

{ #category : #resolving }
MicHTTPResource >> resolvedBy: aRoot [

	^ self
]

{ #category : #converting }
MicHTTPResource >> string: aString [

	super string: aString.
	urlOrFileReference := ZnUrlCopy fromString: originalString.
]
