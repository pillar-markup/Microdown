"
I am a relative reference.

I specify a ressource relative to an other reference. One example is the path `../images/logo.png` which says the logo is in the image direcctory of my parent directory. However, I am unresolved, and need to be resolved with respect to an absolute reference (file or http). 
"
Class {
	#name : #MicRelativeResourceReference,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #testing }
MicRelativeResourceReference >> isImage [

	^ self isImage: originalString 
]

{ #category : #testing }
MicRelativeResourceReference >> isResolved [ 
	^ false
]

{ #category : #accessing }
MicRelativeResourceReference >> path [
	^originalString  
]

{ #category : #accessing }
MicRelativeResourceReference >> relativePath [

	^ originalString 
]

{ #category : #accessing }
MicRelativeResourceReference >> relativePath: aString [

	originalString := aString 
]

{ #category : #resolving }
MicRelativeResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolveRelativeUrl: self
]

{ #category : #accessing }
MicRelativeResourceReference >> resolveWith: baseReference [
	^ MicResourceReference fromUri: (baseReference uri withRelativeReference: self relativePath) asString
]

{ #category : #accessing }
MicRelativeResourceReference >> uri [
	
	^ originalString
]
