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
	^ GHMListBlock
]

{ #category : #factory }
GHMBlockTest >> orderedListBlockClass [
	^ GHMOrderedListBlock
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
	^ GHMRootBlock
]

{ #category : #running }
GHMBlockTest >> setUp [

	super setUp.
	parser := self parser. 
]
