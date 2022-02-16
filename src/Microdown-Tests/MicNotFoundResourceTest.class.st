Class {
	#name : #MicNotFoundResourceTest,
	#superclass : #MicReferenceTestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #testing }
MicNotFoundResourceTest >> errorText [

	^ 'Sample error text'
]

{ #category : #testing }
MicNotFoundResourceTest >> resourceReference [

	^ 'file:///xzyxzy.txt' 

]

{ #category : #running }
MicNotFoundResourceTest >> setUp [

	super setUp.
	resource := MicNotFoundResource 
		resource: self resourceReference
		error: (Error new messageText: self errorText)

]

{ #category : #testing }
MicNotFoundResourceTest >> testAsForm [

	self assert: resource asForm equals: nil

]

{ #category : #testing }
MicNotFoundResourceTest >> testAsText [

	self assert: resource asText equals: 'Resource not found' asText
]

{ #category : #testing }
MicNotFoundResourceTest >> testError [

	self assert: (resource error isKindOf: Error).
	self assert: resource error messageText equals: self errorText

]

{ #category : #testing }
MicNotFoundResourceTest >> testExists [

	self deny: resource exists

]

{ #category : #testing }
MicNotFoundResourceTest >> testNotFoundReference [

	self assert: resource reference equals: self resourceReference

]

{ #category : #testing }
MicNotFoundResourceTest >> testParseMicrodown [

	self should: [ resource parseMicrodown ] raise: Error

]
