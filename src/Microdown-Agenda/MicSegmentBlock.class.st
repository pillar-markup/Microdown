"
I represent a Segment of a Day which i contains all the differents components which are my children.
"
Class {
	#name : #MicSegmentBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #accessing }
MicSegmentBlock class >> tag [
	^ #segment
]

{ #category : #visiting }
MicSegmentBlock >> accept: aVisitor [
	^ aVisitor visitSegment: self
]

{ #category : #accessing }
MicSegmentBlock >> start [
	
	^ self arguments at: #start ifAbsent: [ 'There is no start' ]
]

{ #category : #accessing }
MicSegmentBlock >> start: aStart [
	
	arguments at: #start put: aStart
]
