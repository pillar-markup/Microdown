Class {
	#name : #MicPharoClassResourceTest,
	#superclass : #MicReferenceTestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicPharoClassResourceTest >> setUp [

	super setUp.
	resource := MicPharoClassResource 
		on: OrderedCollection 
		reference: self resourceReference

]

{ #category : #testing }
MicPharoClassResourceTest >> testAsText [

	self assert: (resource asText isKindOf: Text).
	self
		assert: resource asText
		equals: resource theClass definitionString
]

{ #category : #testing }
MicPharoClassResourceTest >> testContents [

	self 
		assert: resource contents 
		equals: resource theClass definitionString

]

{ #category : #testing }
MicPharoClassResourceTest >> testTheClass [

	self assert: resource theClass equals: OrderedCollection.
	resource theClass: Dictionary.
	self assert: resource theClass equals: Dictionary.
	

]
