Class {
	#name : #MicAgendaBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'parser'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Agenda-Tests'
}

{ #category : #running }
MicAgendaBlockTest >> setUp [

	super setUp.
	builder := MicMicrodownTextualBuilder new.
	parser := Microdown new.
]

{ #category : #tests }
MicAgendaBlockTest >> testAgenda [
	"'<!agenda
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'agenda', String cr,
	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicAgendaBlock). 
	self assert: env environmentName equals: 'agenda'
]

{ #category : #tests }
MicAgendaBlockTest >> testAgendaWithArgument [
	"'<!agenda|title='A cool agenda'
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'agenda|title=A cool agenda', 	String cr, 	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicAgendaBlock). 
	self assert: env environmentName equals: 'agenda'.
	self assert: env title equals: 'A cool agenda'
]
