"
I represent a Talk in a Segment like a presentation of a new tool or projet by someone for a certains amount of time at a certain place.
"
Class {
	#name : #MicTalkBlock,
	#superclass : #MicAbstractComponentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #accessing }
MicTalkBlock class >> tag [
	^ #talk
]

{ #category : #visiting }
MicTalkBlock >> accept: aVisitor [
	^ aVisitor visitTalk: self
]
