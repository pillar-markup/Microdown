Class {
	#name : #MicElementTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #testing }
MicElementTest class >> isAbstract [ 

	^ self = MicElementTest
]

{ #category : #factory }
MicElementTest >> listBlockClass [
	^ MicListBlock
]

{ #category : #factory }
MicElementTest >> orderedListBlockClass [
	^ MicOrderedListBlock
]

{ #category : #factory }
MicElementTest >> parser [
	^ self parserClass new
]

{ #category : #factory }
MicElementTest >> parserClass [
	"This references to MicrodownParser is needed for the test.
	Replacing it by Microdown does not work."
	
	^ MicrodownParser
]

{ #category : #factory }
MicElementTest >> rootBlockClass [
	^ MicRootBlock
]

{ #category : #initialization }
MicElementTest >> setUp [

	super setUp.
	parser := self parser. 
]
