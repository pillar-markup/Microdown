Class {
	#name : #MicHttpResource,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicHttpResource class >> on: anEntity [

	^ self new
		entity: anEntity;
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
