Class {
	#name : #MicPharoImageResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resolution'
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

{ #category : #tests }
MicPharoImageResourceReferenceTest >> testSingleSlash [

	| uri |
	uri := 'pharo:/Object/iconNamed:/info' asMicResourceReference.
	self assert: uri isRelative. "If this fails, ZnUrl has been fixed"
	self assert: uri class ~= MicPharoImageResourceReference  
]
