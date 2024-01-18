Class {
	#name : 'MicAnnotationSubclassTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'running' }
MicAnnotationSubclassTest >> setUp [
	super setUp.
	parser := Microdown new
]
