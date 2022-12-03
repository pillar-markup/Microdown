Class {
	#name : #MicDayBlockTest,
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
MicDayBlockTest >> setUp [

	super setUp.
	builder := MicMicrodownTextualBuilder new.
	parser := Microdown new.
]

{ #category : #tests }
MicDayBlockTest >> testDay [
	"'<!day
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'day', String cr,
	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicDayBlock). 
	self assert: env environmentName equals: 'day'
]

{ #category : #tests }
MicDayBlockTest >> testDayWithArgument [
	"'<!day|start=05/12/2022
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'day|start=05/12/2022', 	String cr, 	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicDayBlock). 
	self assert: env environmentName equals: 'day'.
	self assert: env start equals: '05/12/2022'
]
