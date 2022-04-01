Class {
	#name : #MicPharoImageResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Core'
}

{ #category : #tests }
MicPharoImageResourceReferenceTest >> testIcon [

	| uri image |
	uri := 'pharo:///Object/iconNamed:/info' asMicResourceReference.
	image := uri loadImage.

	self assert: image equals: (Object iconNamed: #info)
]
