"
A MicMicrodownTextualBuilderTest is a test class for testing the behavior of MicMicrodownTextualBuilder
"
Class {
	#name : #MicMicrodownTextualBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'parser',
		'builder'
	],
	#category : #'Microdown-Tests-Builder'
}

{ #category : #initialization }
MicMicrodownTextualBuilderTest >> setUp [
	super setUp.
	factory := MicMicroDownSnippetFactory new.
	parser := MicroDownParser new.
	builder := parser builder
]

{ #category : #initialization }
MicMicrodownTextualBuilderTest >> testAnchor [

	self assert: (builder anchor: 'Anchor') contents equals: '@Anchor'
]
