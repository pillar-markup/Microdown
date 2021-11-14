Class {
	#name : #MicFileResource,
	#superclass : #MicResourceReference,
	#instVars : [
		'uri'
	],
	#classVars : [
		'Hosts'
	],
	#category : #'Microdown-Core'
}

{ #category : #'as yet unclassified' }
MicFileResource class >> host: hostName is: aBlock [
	self hosts at: hostName put: aBlock
]

{ #category : #'as yet unclassified' }
MicFileResource class >> hostFileReference: hostName [
	"returns a file reference for the host, or nil if no such host exists"
	^ (self hosts at: hostName ifAbsent: [ ^ nil ]) value
]

{ #category : #'as yet unclassified' }
MicFileResource class >> hosts [
	Hosts ifNil: [ 
		Hosts := Dictionary new. 
		self populateHosts ].
	^ Hosts
	
]

{ #category : #'as yet unclassified' }
MicFileResource class >> initialize [ 
	<script>
	Hosts := nil.
]

{ #category : #'as yet unclassified' }
MicFileResource class >> populateHosts [
	self halt.
	self host: #localhost is: [ FileSystem disk root asFileReference   ].
	self host: #workingdirectory is: [ FileSystem workingDirectory  ]
]

{ #category : #'as yet unclassified' }
MicFileResource class >> removeHost: hostName [
	self hosts removeKey: hostName ifAbsent: [  ]
]

{ #category : #converting }
MicFileResource >> asFileReference [
	| hostRef |
	uri host ifNil: [ ^ uri asFileReference  ].
	hostRef := self class hostFileReference: uri host asSymbol.
	hostRef ifNil: [ ^ uri asFileReference  ].
	self halt.
]

{ #category : #converting }
MicFileResource >> fullName [ 
	^ urlOrFileReference fullName
]

{ #category : #testing }
MicFileResource >> isImage [

	^ self isImage: uri segments last
]

{ #category : #testing }
MicFileResource >> isResolved [  
	^ true
]

{ #category : #'accessing - resources' }
MicFileResource >> loadImage [
	"return an image form from my reference"
	| image |
	image := ImageReadWriter formFromStream: uri asFileReference binaryReadStream  .
	^ image
]

{ #category : #'accessing - resources' }
MicFileResource >> loadMicrodown [
	"load, parse and resolve a microdown document"
	| docString doc |
	docString := uri asFileReference contents.
	doc := Microdown new parse: docString.
	^doc
]

{ #category : #accessing }
MicFileResource >> path [
	^ '/', self uri path
]

{ #category : #converting }
MicFileResource >> resolvedBy: aRoot [
	
	^ (aRoot isKindOf: FileReference)
			ifTrue: [ MicFileResource new 
								originalString: originalString; 
								url: (aRoot resolvePath: self path) ]
			ifFalse: [ 
					MicHTTPResource new 
								originalString: originalString;
								url: (aRoot withRelativeReference: originalString) ].
]

{ #category : #converting }
MicFileResource >> resolvedBy: parentPath withResolver: aResolver [
	
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
			| resolverPath |
			resolverPath := aResolver resolutionSource path.
			self class new 
				originalString: originalString; 
				url: (aResolver resolutionSource resolvePath: (resolverPath resolvePath: (parentPath resolvePath: self path))) ]
			
]

{ #category : #converting }
MicFileResource >> resolvedWithResolver: aResolver [
	"Experimental"
	^ (aResolver resolutionSource isKindOf: ZnUrl)
		ifTrue: [ 
			"I'm http://files.pharo.org/...."
			| resolverPath |
			"needed because withRelatedReference: does not handle well http://pharo.org/figures/"
			resolverPath := Path from: aResolver resolutionSource path.
			MicHTTPResource new 
				originalString: originalString; 
				url: (aResolver resolutionSource withRelativeReference: resolverPath) ]
		ifFalse: [ 
			"I have a file reference but no filesystem (for example a pharo image) + and local path"
			| resolverPath |
			resolverPath := aResolver resolutionSource path.
			self class new 
				originalString: originalString; 
				url: (aResolver resolutionSource resolvePath: (resolverPath resolvePath: self path)) ]
			
]

{ #category : #converting }
MicFileResource >> string: aString [

	super string: aString.
	urlOrFileReference := Path from: originalString
]

{ #category : #accessing }
MicFileResource >> uri [

	^ uri
]

{ #category : #accessing }
MicFileResource >> uri: anObject [

	uri := anObject
]
