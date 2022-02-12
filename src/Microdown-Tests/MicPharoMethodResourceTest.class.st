Class {
	#name : #MicPharoMethodResourceTest,
	#superclass : #MicReferenceTestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicPharoMethodResourceTest >> methodReference [

	^ OrderedCollection >> #add:
]

{ #category : #running }
MicPharoMethodResourceTest >> setUp [

	super setUp.
	resource := MicPharoMethodResource
		on: self methodReference
		reference: self resourceReference
]

{ #category : #running }
MicPharoMethodResourceTest >> testAsText [

	self assert: (resource asText isKindOf: Text).
	self
		assert: resource asText
		equals: resource theMethod definitionString
]

{ #category : #running }
MicPharoMethodResourceTest >> testContents [

	self 
		assert: resource contents 
		equals: resource theMethod definitionString

]

{ #category : #running }
MicPharoMethodResourceTest >> testTheMethod [

	self assert: resource theMethod equals: self methodReference.
	resource theMethod: Dictionary >> #at:.
	self assert: resource theMethod equals: Dictionary >> #at:.

]
