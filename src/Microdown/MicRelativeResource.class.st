Class {
	#name : #MicRelativeResource,
	#superclass : #MicResourceReference,
	#instVars : [
		'relativePath'
	],
	#category : #'Microdown-Core'
}

{ #category : #testing }
MicRelativeResource >> isImage [

	^ self isImage: relativePath
]

{ #category : #testing }
MicRelativeResource >> isResolved [ 
	^ false
]

{ #category : #accessing }
MicRelativeResource >> path [
	^relativePath 
]

{ #category : #accessing }
MicRelativeResource >> relativePath [

	^ relativePath
]

{ #category : #accessing }
MicRelativeResource >> relativePath: anObject [

	relativePath := anObject
]

{ #category : #'as yet unclassified' }
MicRelativeResource >> resolveWith: baseReference [
	^ MicResourceReference fromUri: (baseReference uri withRelativeReference: self relativePath) asString
]
