Class {
	#name : #MicInputfileBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #running }
MicInputfileBlockTest >> setUp [
	super setUp.
	parser := MicroDownParser new
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePath [
	| mic |
	mic := parser parse: '?{inputfile|path=file://chapters/withStyle.mic}?'.
	self assert: mic children first children first path equals: 'file://chapters/withStyle.mic'
]
