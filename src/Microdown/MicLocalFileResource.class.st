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
	self halt.
	
	^ (aRoot isKindOf: FileReference)
			ifTrue: [ MicLocalFileResource new 
								originalString: originalString; 
								url: (aRoot resolvePath: self path) ]
			ifFalse: [ 
					MicHTTPResource new 
								originalString: originalString;
								url: (aRoot withRelativeReference: originalString) ].
]

{ #category : #converting }
MicLocalFileResource >> resolvedBy: parentPath withResolver: aResolver [
	"a root is a path for example the path of the file containing the expression
	aResolver is way to resolve path like URL or filesystem
	"

	"I'm a path to a resource.... I should resolve look at its root (parentPath)"
	
	^ (aResolver resolutionSource isKindOf: ZnUrl)
		ifTrue: [ 
			"I'm http://files.pharo.org/...."
			| resolverPath |
			"needed because withRelatedReference: does not handle well http://pharo.org/figures/"
			resolverPath := Path from: aResolver resolutionSource path.
			MicHTTPResource new 
				originalString: originalString; 
				url: (aResolver resolutionSource withRelativeReference: (resolverPath resolvePath: self path ) pathString) ]
		ifFalse: [ 
			"I have a filesystem + parentPath and local path"
			MicLocalFileResource new 
				originalString: originalString; 
				url: (aResolver resolutionSource resolvePath: (parentPath resolvePath: self path)) ]
			
]

{ #category : #converting }
MicLocalFileResource >> string: aString [

	super string: aString.
	urlOrFileReference := Path from: originalString
]
