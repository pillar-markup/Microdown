Class {
	#name : #MicHTTPResource,
	#superclass : #MicResourceReference,
	#instVars : [
		'uri'
	],
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

{ #category : #testing }
MicHTTPResource >> isImage [

	^ self isImage: uri segments last
]

{ #category : #testing }
MicHTTPResource >> isResolved [  
	^ true
]

{ #category : #testing }
MicHTTPResource >> isWeb [

	^ urlOrFileReference isWeb
]

{ #category : #'accessing - resources' }
MicHTTPResource >> loadImage [
	"return an image form from my reference"
	| image |
	image := ZnEasy getPng: uri.
	^ image
]

{ #category : #'accessing - resources' }
MicHTTPResource >> loadMicrodown [
	"load, parse and resolve a microdown document"
	| docString doc |
	docString := (ZnEasy get: uri) contents.
	doc := Microdown new parse: docString.
	MicZinkPathResolver resolve: doc withBase: uri.
	^doc
]

{ #category : #querying }
MicHTTPResource >> query [
	^ urlOrFileReference query
]

{ #category : #resolving }
MicHTTPResource >> resolvedBy: parentPath withResolver: aResolver [
	"I'm url resource so I do not care about a root"

	^ (aResolver resolutionSource isKindOf: ZnUrl)
			ifTrue: [
				"we want to resolve over for example http://github.com/pharo-project...."
				MicHTTPResource new 
								originalString: originalString; 
								url: (aResolver resolutionSource withRelativeReference: self path) ]
			ifFalse: [ 
				"Now I resolve again a file system... well this is http so I do not care about the resolver"
				self				
				]


]

{ #category : #resolving }
MicHTTPResource >> resolvedWithResolver: aResolver [
	"I'm url resource so I do not care about a root"
	"Experimental"
	^ (aResolver resolutionSource isKindOf: ZnUrl)
			ifTrue: [
				"we want to resolve over for example http://github.com/pharo-project...."
				MicHTTPResource new 
								originalString: originalString; 
								url: (aResolver resolutionSource withRelativeReference: self path) ]
			ifFalse: [ 
				"Now I resolve again a file system... well this is http so I do not care about the resolver"
				self				
				]


]

{ #category : #converting }
MicHTTPResource >> string: aString [

	super string: aString.
	urlOrFileReference := MicZnUrl fromString: originalString.
]

{ #category : #accessing }
MicHTTPResource >> uri [

	^ uri
]

{ #category : #accessing }
MicHTTPResource >> uri: anObject [

	uri := anObject
]
