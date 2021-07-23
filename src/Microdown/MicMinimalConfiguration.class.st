Class {
	#name : #MicMinimalConfiguration,
	#superclass : #Object,
	#instVars : [
		'newLine',
		'headingLevelOffset'
	],
	#category : #'Microdown-Utils'
}

{ #category : #accessing }
MicMinimalConfiguration >> headingLevelOffset [

	^ headingLevelOffset
]

{ #category : #accessing }
MicMinimalConfiguration >> headingLevelOffset: anObject [

	headingLevelOffset := anObject
]

{ #category : #initialization }
MicMinimalConfiguration >> initialize [ 
	super initialize.
	newLine := String cr.
	headingLevelOffset := 0
]

{ #category : #accessing }
MicMinimalConfiguration >> newLine [
	^ newLine
]

{ #category : #accessing }
MicMinimalConfiguration >> newLine: aString [
	newLine := aString
]
