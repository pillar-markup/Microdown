"
A MicrodownTest is a test class for testing the behavior of Microdown
"
Class {
	#name : 'MicrodownTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Core',
	#package : 'Microdown-Tests',
	#tag : 'Core'
}

{ #category : 'tests - parent/children' }
MicrodownTest >> testAddedAsChildWhenUsingParent [

	| h t|
	h := MicHeaderBlock new.
	t := MicTextBlock new.
	t bodyString: 'Blblbl'.
	t parent: h.
	self assert: h children size equals: 1.
	self assert: h children first equals: t.
	self assert: t parent equals: h
]

{ #category : 'tests' }
MicrodownTest >> testMicrodownSpelledCorrect [
	self assert: (Object allSubclasses select: [ :c | c name beginsWith: 'MicroDown' ]) isEmpty
]

{ #category : 'tests - parent/children' }
MicrodownTest >> testParentBackLinkIsSet [

	| h t|
	h := MicHeaderBlock new.
	t := MicTextBlock new.
	t bodyString: 'Blblbl'.
	h addChild: t.
	self assert: h children size equals: 1.
	self assert: h children first equals: t.
	self assert: t parent equals: h
]
