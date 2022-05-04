Class {
	#name : #MicPharoImageResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Core'
}

{ #category : #'test support' }
MicPharoImageResourceReferenceTest class >> microdownProducingMethod [
	^ Microdown parse: 'I am **bold**'
]

{ #category : #tests }
MicPharoImageResourceReferenceTest >> testIcon [

	| uri image |
	uri := 'pharo:///Object/iconNamed:/info' asMicResourceReference.
	image := uri loadImage.

	self assert: image equals: (Object iconNamed: #info)
]

{ #category : #tests }
MicPharoImageResourceReferenceTest >> testMicrodownImport [

	| ref doc |
	ref := 'pharo:///MicPharoImageResourceReferenceTest/microdownProducingMethod'
		asMicResourceReference.
	doc := ref loadMicrodown.

	self assert: doc children notEmpty
]
