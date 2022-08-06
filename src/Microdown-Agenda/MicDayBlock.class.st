"
I represent a Day in a Agenda with all my differents segment which are my children.
"
Class {
	#name : #MicDayBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #accessing }
MicDayBlock class >> tag [
	^ #day
]

{ #category : #visiting }
MicDayBlock >> accept: aVisitor [
	^ aVisitor visitDay: self
]

{ #category : #accessing }
MicDayBlock >> start [
	
	^ self arguments at: #start ifAbsent: [ 'There is no start' ]
]

{ #category : #accessing }
MicDayBlock >> start: aStart [
	
	arguments at: #start put: aStart
]
