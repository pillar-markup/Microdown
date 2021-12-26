Class {
	#name : #MicDefaultResolver,
	#superclass : #Object,
	#instVars : [
		'defaultImage'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #accessing }
MicDefaultResolver >> defaultImage: aForm [ 
	defaultImage := aForm
]

{ #category : #resolving }
MicDefaultResolver >> resolveUrl: aMicHTTPResource [ 
	
	^ defaultImage
]
