Class {
	#name : 'MicBlockTest',
	#superclass : 'MicElementTest',
	#instVars : [
		'subject'
	],
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'testing' }
MicBlockTest class >> isAbstract [ 

	^ self = MicBlockTest
]

{ #category : 'tests' }
MicBlockTest >> subject [

	^ subject ifNil: [ subject := self subjectClass new ]
]

{ #category : 'tests' }
MicBlockTest >> subjectClass [
	^ self subclassResponsibility 
]

{ #category : 'tests' }
MicBlockTest >> testHasProperty [
	self deny: (self subject hasProperty: #foo).
	self subject propertyAt: #foo put: 'bar'.
	self assert: (self subject hasProperty: #foo).
	self deny: (self subject hasProperty: #bar)
]

{ #category : 'tests' }
MicBlockTest >> testProperties [
	self assert: self subject properties isNotNil.
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo put: #bar.
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo ifAbsent: [ nil ].
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo ifAbsentPut: [ #bar ].
	self subject instVarNamed: 'properties' put: nil.

	self subject hasProperty: #foo.
	self subject instVarNamed: 'properties' put: nil
]

{ #category : 'tests' }
MicBlockTest >> testPropertyAt [
	self assert: (self subject propertyAt: #foo put: 'bar') equals: 'bar'.
	self assert: (self subject propertyAt: #foo) equals: 'bar'.
	self should: [ self subject propertyAt: #bar ] raise: MicPropertyError
]

{ #category : 'tests' }
MicBlockTest >> testPropertyAtIfAbsent [
	self assert: (self subject propertyAt: #foo put: 'bar') equals: 'bar'.
	self assert: (self subject propertyAt: #foo ifAbsent: [ 'baz' ]) equals: 'bar'.
	self assert: (self subject propertyAt: #bar ifAbsent: [ 'baz' ]) equals: 'baz'
]

{ #category : 'tests' }
MicBlockTest >> testPropertyAtPut [
	self subject propertyAt: #foo put: 'bar'.
	self assert: (self subject propertyAt: #foo) equals: 'bar'.

	self subject propertyAt: #foo put: 'baz'.
	self assert: (self subject propertyAt: #foo) equals: 'baz'
]

{ #category : 'tests' }
MicBlockTest >> testSanity [
	"If this test case fails, there is something wrong with the setup of the test-case."

	self
		assert: self subjectClass isAbstract not
		description: 'Unable to test abstract class.'.
	self
		assert: self subject class equals: self subjectClass
		
]
