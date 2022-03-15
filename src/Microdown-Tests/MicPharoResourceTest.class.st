Class {
	#name : #MicPharoResourceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicPharoResourceTest >> testIcon [

	| uri image |
	uri := 'pharo:///Object/iconNamed:/info' asMicResourceReference.
	image := uri loadImage.

	self assert: image equals: (Object iconNamed: #info)
]
