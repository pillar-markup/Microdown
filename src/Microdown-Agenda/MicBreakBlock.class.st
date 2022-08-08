"
I represent a Break in a Segment like a break for lunch or a coffee time for a certain amount of time at a certain place.
"
Class {
	#name : #MicBreakBlock,
	#superclass : #MicAbstractComponentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #accessing }
MicBreakBlock class >> tag [
	^ #break
]

{ #category : #visiting }
MicBreakBlock >> accept: aVisitor [
	^ aVisitor visitBreak: self
]

{ #category : #accessing }
MicBreakBlock >> author [
	
	^ self arguments at: #author ifAbsent: [ '' ]
]
