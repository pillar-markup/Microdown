"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicHTTPResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolveUrl: self
]
