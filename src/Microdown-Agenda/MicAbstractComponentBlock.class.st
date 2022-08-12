"
I am an abstractComponent which represent the standard behaviour of each components of a Segment.
"
Class {
	#name : #MicAbstractComponentBlock,
	#superclass : #MicSegmentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #testing }
MicAbstractComponentBlock class >> isAbstract [ 
	
	^ self == MicAbstractComponentBlock
]

{ #category : #accessing }
MicAbstractComponentBlock >> author [
	
	^ self arguments at: #author ifAbsent: [ 'Not Specified' ]
]

{ #category : #accessing }
MicAbstractComponentBlock >> author: anAuthor [
	
	arguments at: #author put: anAuthor
]

{ #category : #accessing }
MicAbstractComponentBlock >> length [
	
	^ self arguments at: #length ifAbsent: [ 'There is no length' ]
]

{ #category : #accessing }
MicAbstractComponentBlock >> length: aLength [
	
	arguments at: #length put: aLength 
]

{ #category : #accessing }
MicAbstractComponentBlock >> room [
	
	^ self arguments at: #room ifAbsent: [ 'Not Specified' ]
]

{ #category : #accessing }
MicAbstractComponentBlock >> room: aRoom [
	
	arguments at: #room put: aRoom
]

{ #category : #accessing }
MicAbstractComponentBlock >> subject [
	
	^ self arguments at: #subject ifAbsent: [ 'There is no subject' ]
]

{ #category : #accessing }
MicAbstractComponentBlock >> subject: aSubject [
	
	arguments at: #subject put: aSubject 
]
