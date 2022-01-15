Class {
	#name : #MicRelativeUrlResolver,
	#superclass : #MicUrlResolver,
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicRelativeUrlResolver class >> baseUrlString: baseUrl [

	^ self new
		baseUrlString: baseUrl;
		yourself
]

{ #category : #resolving }
MicRelativeUrlResolver >> basicResolveRelativeReference: aMicRelativeResource [ 
	
	^ super basicResolveRelativeReference: (MicResourceReference fromUri: (baseUrl, aMicRelativeResource uri) asString)
]
