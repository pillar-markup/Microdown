"
I represent an Agenda which contain the differents days which are my children.
"
Class {
	#name : #MicAgendaBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Agenda'
}

{ #category : #accessing }
MicAgendaBlock class >> tag [
	^ #agenda
]

{ #category : #visiting }
MicAgendaBlock >> accept: aVisitor [
	^ aVisitor visitAgenda: self
]

{ #category : #accessing }
MicAgendaBlock >> title [
	
	^ self arguments at: #title ifAbsent: [ 'There is no title' ]
]

{ #category : #accessing }
MicAgendaBlock >> title: aTitle [
	
	arguments at: #title put: aTitle
]
