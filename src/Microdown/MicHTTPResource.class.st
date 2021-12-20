Class {
	#name : #MicHttpResource,
	#superclass : #Object,
	#instVars : [
		'entity',
		'reference'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicHttpResource class >> on: anEntity reference: aReference [

	^ self new
		entity: anEntity;
		reference: aReference;
		yourself
]

{ #category : #converting }
MicHttpResource >> asForm [

	^ ImageReadWriter formFromStream: entity readStream
]

{ #category : #accessing }
MicHttpResource >> entity [

	^ entity
]

{ #category : #accessing }
MicHttpResource >> entity: anObject [

	entity := anObject
]

{ #category : #converting }
MicHttpResource >> parseMicrodown [
	
	| doc |
	doc := Microdown new parse: entity contents.
	MicZincPathResolver resolve: doc withBase: reference uri.
	^doc
]

{ #category : #accessing }
MicHttpResource >> reference [

	^ reference
]

{ #category : #accessing }
MicHttpResource >> reference: anObject [

	reference := anObject
]
