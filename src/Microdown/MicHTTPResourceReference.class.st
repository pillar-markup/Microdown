"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicHTTPResourceReference >> loadMicrodown [
	"load, parse and resolve a microdown document"
	| docString doc |
	docString := (ZnEasy get: uri) contents.
	doc := Microdown new parse: docString.
	MicZincPathResolver resolve: doc withBase: uri.
	^doc
]

{ #category : #'accessing - resources' }
MicHTTPResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolveUrl: self
]
