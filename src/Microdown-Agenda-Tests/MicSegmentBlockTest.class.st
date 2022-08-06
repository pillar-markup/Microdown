Class {
	#name : #MicSegmentBlockTest,
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
MicSegmentBlockTest >> setUp [

	super setUp.
	builder := MicMicrodownTextualBuilder new.
	parser := Microdown new.
]

{ #category : #tests }
MicSegmentBlockTest >> testSegment [
	"'<!segment
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'segment',
	String cr, 	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicSegmentBlock). 
	self assert: env environmentName equals: 'segment'.
]

{ #category : #tests }
MicSegmentBlockTest >> testSegmentWithArgument [
	"'<!segment|start=10h
!>
'" 
	| source root env|
	source := EnvironmentOpeningBlockMarkup , 'segment|start=10h', 	String cr, 	EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	env := root children first. 
	self assert: (env isKindOf: MicSegmentBlock). 
	self assert: env environmentName equals: 'segment'.
	self assert: env start equals: '10h'
]
