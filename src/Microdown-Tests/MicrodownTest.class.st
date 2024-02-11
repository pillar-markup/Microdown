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

{ #category : 'tests' }
MicrodownTest >> testMicrodownSpelledCorrect [
	self assert: (Object allSubclasses select: [ :c | c name beginsWith: 'MicroDown' ]) isEmpty
]
