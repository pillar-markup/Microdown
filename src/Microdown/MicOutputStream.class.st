"
I'm a little wrapper on stream to provide a nicer API. In particular I help not hardcoding line ending everywhere.
"
Class {
	#name : 'MicOutputStream',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'configuration'
	],
	#category : 'Microdown-Utils',
	#package : 'Microdown',
	#tag : 'Utils'
}

{ #category : 'instance creation' }
MicOutputStream class >> on: aStream [

	^ self new setStream: aStream; yourself
]

{ #category : 'streaming' }
MicOutputStream >> << anObject [
	anObject isBlock
		ifTrue: anObject
		ifFalse: [ stream << anObject ]
]

{ #category : 'accessing' }
MicOutputStream >> configuration [ 
	^ configuration
]

{ #category : 'accessing' }
MicOutputStream >> configuration: aConfiguration [
	configuration := aConfiguration 
]

{ #category : 'streaming' }
MicOutputStream >> contents [

	^ stream contents
]

{ #category : 'accessing' }
MicOutputStream >> crAsNewLine [

	self configuration crAsNewLine
]

{ #category : 'accessing' }
MicOutputStream >> crlfAsNewLine [

	self configuration crlfAsNewLine
]

{ #category : 'accessing' }
MicOutputStream >> flush [
	stream flush
]

{ #category : 'initialization' }
MicOutputStream >> initialize [ 
	super initialize.
	configuration := MicMinimalConfiguration new.
]

{ #category : 'testing' }
MicOutputStream >> isEmpty [
	
	^ stream isEmpty
]

{ #category : 'accessing' }
MicOutputStream >> lfAsNewLine [

	self configuration lfAsNewLine
]

{ #category : 'streaming' }
MicOutputStream >> newLine [
	self << self usedNewLine
]

{ #category : 'accessing' }
MicOutputStream >> nextPut: aCharacter [ 
	stream nextPut: aCharacter
]

{ #category : 'accessing' }
MicOutputStream >> nextPutAll: aCharacter [ 
	stream nextPutAll: aCharacter
]

{ #category : 'accessing' }
MicOutputStream >> print: anObject [
	stream print: anObject
]

{ #category : 'initialization' }
MicOutputStream >> setStream: aWriteStream [
	stream := aWriteStream
]

{ #category : 'streaming' }
MicOutputStream >> space [
	stream space
]

{ #category : 'private' }
MicOutputStream >> stream [

	^ stream
]

{ #category : 'streaming' }
MicOutputStream >> tab [
	stream tab
]

{ #category : 'streaming' }
MicOutputStream >> trimLastNewLine [
	| newLine |
	newLine := self usedNewLine.
	(newLine isEmpty or: [ stream position < newLine size ])
		ifTrue: [ ^ self ].
	stream position: stream position - newLine size.
]

{ #category : 'streaming' }
MicOutputStream >> usedNewLine [
	^ self configuration newLine
]
