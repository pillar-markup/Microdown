Class {
	#name : #MicBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #running }
MicBuilderTest >> setUp [ 
	super setUp.
	builder := MicBuilder new.
	parser := MicroDownParser new.
]

{ #category : #running }
MicBuilderTest >> testCodeblock [
	
	| tree | 
	builder 
		buildCodeblockTag: #pharo 
 		withBody: '1 + 2'.
	tree := parser parse: builder contents.
	self assert: tree children first class = MicCodeBlock.
	
]
