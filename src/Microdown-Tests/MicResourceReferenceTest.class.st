Class {
	#name : #MicResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicResourceReferenceTest >> fileReferenceClass [

	^ MicResourceReference
]

{ #category : #tests }
MicResourceReferenceTest >> testParseFullUrl [

	| mf |
	mf := self fileReferenceClass fromString: 'http://server/m.mic'.
	self assert: mf url asString equals: 'http://server/m.mic'
]
