Class {
	#name : #MicNotFoundResource,
	#superclass : #Object,
	#instVars : [
		'notFoundResource',
		'error'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicNotFoundResource class >> resource: aResource error: anError [
	
	^ self new
		notFoundResource: aResource;
		error: anError;
		yourself
]

{ #category : #converting }
MicNotFoundResource >> asForm [
	
	^ nil
]

{ #category : #accessing }
MicNotFoundResource >> error [

	^ error
]

{ #category : #accessing }
MicNotFoundResource >> error: anError [

	error := anError
]

{ #category : #accessing }
MicNotFoundResource >> notFoundResource [

	^ notFoundResource
]

{ #category : #accessing }
MicNotFoundResource >> notFoundResource: anObject [

	notFoundResource := anObject
]
