Class {
	#name : #MicUrlResolver,
	#superclass : #MicFullResolver,
	#category : #'Microdown-Core'
}

{ #category : #resolving }
MicUrlResolver >> basicResolveRelativeUrl: aMicRelativeResource [ 
	
	^ self basicResolveUrl: aMicRelativeResource
]

{ #category : #resolving }
MicUrlResolver >> basicResolveUrl: anAbsoluteFileURL [

	| client |
	[
	(client := ZnEasy client)
		url: anAbsoluteFileURL uri asString;
		enforceHttpSuccess: true;
		get ] on: ZnHttpUnsuccessful do: [ :error |
			^ MicNotFoundResource resource: anAbsoluteFileURL error: error ].

	^ MicHttpResource on: client entity reference: anAbsoluteFileURL
]
