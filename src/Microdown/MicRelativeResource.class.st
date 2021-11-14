Class {
	#name : #MicRelativeResource,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #testing }
MicRelativeResource >> isImage [

	^ self isImage: originalString 
]

{ #category : #testing }
MicRelativeResource >> isResolved [ 
	^ false
]

{ #category : #accessing }
MicRelativeResource >> path [
	^originalString  
]

{ #category : #accessing }
MicRelativeResource >> relativePath [

	^ originalString 
]

{ #category : #accessing }
MicRelativeResource >> relativePath: aString [

	originalString := aString 
]

{ #category : #'as yet unclassified' }
MicRelativeResource >> resolveWith: baseReference [
	^ MicResourceReference fromUri: (baseReference uri withRelativeReference: self relativePath) asString
]
