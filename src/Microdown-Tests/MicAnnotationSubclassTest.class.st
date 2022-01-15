Class {
	#name : #MicAnnotationSubclassTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #running }
MicAnnotationSubclassTest >> setUp [
	super setUp.
	parser := Microdown new
]
