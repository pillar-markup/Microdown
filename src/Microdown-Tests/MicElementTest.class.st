Class {
	#name : 'MicElementTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'testing' }
MicElementTest class >> isAbstract [ 

	^ self = MicElementTest
]

{ #category : 'factory' }
MicElementTest >> parser [
	^ self parserClass new
]

{ #category : 'factory' }
MicElementTest >> parserClass [
	"This references to MicrodownParser is needed for the test.
	Replacing it by Microdown does not work."
	
	^ MicrodownParser
]

{ #category : 'running' }
MicElementTest >> setUp [

	super setUp.
	parser := self parser. 
]
