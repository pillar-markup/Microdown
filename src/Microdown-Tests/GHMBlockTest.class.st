Class {
	#name : #GHMBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Tests'
}

{ #category : #factory }
GHMBlockTest >> listBlockClass [
	^ MicListBlock
]

{ #category : #factory }
GHMBlockTest >> orderedListBlockClass [
	^ MicOrderedListBlock
]

{ #category : #factory }
GHMBlockTest >> parser [
	^ self parserClass new
]

{ #category : #factory }
GHMBlockTest >> parserClass [
	^ GHMParser
]

{ #category : #factory }
GHMBlockTest >> rootBlockClass [
	^ MicRootBlock
]

{ #category : #running }
GHMBlockTest >> setUp [

	super setUp.
	parser := self parser. 
]
