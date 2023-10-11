Class {
	#name : 'MicMinimalConfiguration',
	#superclass : 'Object',
	#instVars : [
		'newLine',
		'headingLevelOffset'
	],
	#category : 'Microdown-Utils',
	#package : 'Microdown',
	#tag : 'Utils'
}

{ #category : 'accessing' }
MicMinimalConfiguration >> crAsNewLine [

	self newLine: Character cr.
]

{ #category : 'accessing' }
MicMinimalConfiguration >> crlfAsNewLine [

	self newLine: String crlf.
]

{ #category : 'accessing' }
MicMinimalConfiguration >> headingLevelOffset [
	"To be moved in a subclass when we will deal with the pillar integration.
	Check the senders: it should be a visitor that should be packaged out of Microdown and placed in Pillar-Microdown"
	
	^ headingLevelOffset
]

{ #category : 'accessing' }
MicMinimalConfiguration >> headingLevelOffset: anObject [
	"To be moved in a subclass when we will deal with the pillar integration."
	
	headingLevelOffset := anObject
]

{ #category : 'initialization' }
MicMinimalConfiguration >> initialize [ 
	super initialize.
	newLine := String crlf.
	headingLevelOffset := 0
]

{ #category : 'accessing' }
MicMinimalConfiguration >> lfAsNewLine [

	self newLine: Character lf.
]

{ #category : 'accessing' }
MicMinimalConfiguration >> newLine [
	^ newLine
]

{ #category : 'accessing' }
MicMinimalConfiguration >> newLine: aString [
	newLine := aString
]
