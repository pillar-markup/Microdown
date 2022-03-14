"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #streams }
MicHTTPResourceReference >> binaryReadStream [
	^ self bytes readStream 
]

{ #category : #'as yet unclassified' }
MicHTTPResourceReference >> bytes [
	| client |
	[(client := ZnEasy client)
		beBinary;
		url: self uri;
		enforceHttpSuccess: true;
		get ] on: ZnHttpUnsuccessful do: [ :error | 
			error resignalAs: (MicHttpReferenceError new messageText: 'Could not access ', self uri printString)  ].
	^ client entity bytes
]

{ #category : #accessing }
MicHTTPResourceReference >> contents [
	^ self bytes utf8Decoded.
]
