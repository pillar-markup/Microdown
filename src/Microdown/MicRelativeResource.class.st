"
I am a relative reference.

I specify a ressource relative to an other reference. One example is the path `../images/logo.png` which says the logo is in the image direcctory of my parent directory. However, I am unresolved, and need to be resolved with respect to an absolute reference (file or http). 
"
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

{ #category : #accessing }
MicRelativeResource >> resolveWith: baseReference [
	^ MicResourceReference fromUri: (baseReference uri withRelativeReference: self relativePath) asString
]

{ #category : #resolving }
MicRelativeResource >> resolvedBy: aRoot [ 
	
	^ aRoot / originalString
]
