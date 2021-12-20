Class {
	#name : #MicRelativeUrlResolver,
	#superclass : #MicUrlResolver,
	#instVars : [
		'baseUrl'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicRelativeUrlResolver class >> baseUrl: baseUrl [

	^ self new
		baseUrl: baseUrl;
		yourself
]

{ #category : #accessing }
MicRelativeUrlResolver >> baseUrl [

	^ baseUrl
]

{ #category : #accessing }
MicRelativeUrlResolver >> baseUrl: anObject [

	baseUrl := anObject
]

{ #category : #resolving }
MicRelativeUrlResolver >> basicResolveRelativeUrl: aMicRelativeResource [ 
	
	^ super basicResolveRelativeUrl: (MicResourceReference fromUri: (baseUrl withRelativeReference: aMicRelativeResource originalString) asString)
]
