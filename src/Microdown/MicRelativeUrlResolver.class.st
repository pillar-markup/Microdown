Class {
	#name : #MicRelativeUrlResolver,
	#superclass : #MicUrlResolver,
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicRelativeUrlResolver class >> baseUrl: baseUrl [

	^ self new
		baseUrl: baseUrl;
		yourself
]

{ #category : #resolving }
MicRelativeUrlResolver >> basicResolveRelativeReference: aMicRelativeResource [ 
	
	^ super basicResolveRelativeReference: (MicResourceReference fromUri: (baseUrl, aMicRelativeResource uri) asString)
]
