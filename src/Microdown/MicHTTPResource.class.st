Class {
	#name : #MicHttpResource,
	#superclass : #MicAbstractResource,
	#instVars : [
		'entity'
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

{ #category : #visiting }
MicHttpResource >> asRenderedOn: aRenderer withinNode: aNode [

	^ aRenderer renderHttpResource: self inNode: aNode
]

{ #category : #converting }
MicHttpResource >> binaryReadStream [

	^ entity readStream
]

{ #category : #accessing }
MicHttpResource >> contents [
	
	^ entity contents
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
	doc := super parseMicrodown.
	MicZincPathResolver resolve: doc withBase: reference uri.
	^doc
]
