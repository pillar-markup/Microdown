Class {
	#name : #MicBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #factory }
MicBlockTest >> listBlockClass [
	^ GHMListBlock
]

{ #category : #factory }
MicBlockTest >> orderedListBlockClass [
	^ MicOrderedListBlock
]

{ #category : #factory }
MicBlockTest >> parser [
	^ self parserClass new
]

{ #category : #factory }
MicBlockTest >> parserClass [
	^ MicAbstractParser
]

{ #category : #factory }
MicBlockTest >> rootBlockClass [
	^ MicRootBlock
]

{ #category : #running }
MicBlockTest >> setUp [

	super setUp.
	parser := self parser. 
]
