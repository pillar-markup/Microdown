Class {
	#name : #MicLocalFileResource,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicLocalFileResource >> asFileReference [

	^ self
]

{ #category : #converting }
MicLocalFileResource >> fullName [ 
	^ urlOrFileReference fullName
]

{ #category : #converting }
MicLocalFileResource >> resolvedBy: aRoot [

	^ (aRoot isKindOf: FileReference)
			ifTrue: [ MicLocalFileResource new 
								originalString: originalString; 
								url: aRoot / originalString ]
			ifFalse: [ 
					MicHTTPResource new 
								originalString: originalString;
								url: (aRoot withRelativeReference: originalString) ].
]

{ #category : #converting }
MicLocalFileResource >> string: aString [

	super string: aString.
	urlOrFileReference := originalString asFileReference.
]
