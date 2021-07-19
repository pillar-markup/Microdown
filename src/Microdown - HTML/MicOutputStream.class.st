Class {
	#name : #MicOutputStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'configuration'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'instance creation' }
MicOutputStream class >> on: aWriteStream [ 
	^ self new
		setStream: aWriteStream;
		yourself
]

{ #category : #streaming }
MicOutputStream >> << anObject [
	anObject isBlock
		ifTrue: anObject
		ifFalse: [ stream << anObject ]
]

{ #category : #accessing }
MicOutputStream >> configuration [
	^ configuration ifNil: [ configuration := ConfigurationForMicrodown new ]
]

{ #category : #accessing }
MicOutputStream >> configuration: aConfiguration [
	^ configuration := aConfiguration
]

{ #category : #streaming }
MicOutputStream >> contents [
	^ stream contents
]

{ #category : #accessing }
MicOutputStream >> flush [
	stream flush
]

{ #category : #testing }
MicOutputStream >> isEmpty [
	
	^ stream isEmpty
]

{ #category : #streaming }
MicOutputStream >> newLine [
	self << self configuration newLine
]

{ #category : #accessing }
MicOutputStream >> nextPut: aCharacter [ 
	stream nextPut: aCharacter
]

{ #category : #initialization }
MicOutputStream >> setStream: aWriteStream [
	stream := aWriteStream
]

{ #category : #streaming }
MicOutputStream >> space [
	stream space
]

{ #category : #private }
MicOutputStream >> stream [

	^ stream
]

{ #category : #streaming }
MicOutputStream >> tab [
	stream tab
]

{ #category : #streaming }
MicOutputStream >> trimLastNewLine [
	| newLine |
	newLine := self configuration newLine.
	(newLine isEmpty or: [ stream position < newLine size ])
		ifTrue: [ ^ self ].
	stream position: stream position - newLine size.
]
