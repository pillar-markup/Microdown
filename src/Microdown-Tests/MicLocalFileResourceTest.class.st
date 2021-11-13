"
A MicLocalFileResourceTest is a test class for testing the behavior of MicLocalFileResource
"
Class {
	#name : #MicLocalFileResourceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicLocalFileResourceTest >> testLoadImage [
	|uri ref image |
	uri := 'file:///Users/kasper/GITHUB/kasperosterbye/Microdown/doc/testMicrodown/toplevel.png'.
	ref := MicResourceReference  fromUri: uri.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicLocalFileResourceTest >> testLoadMicrodown [
	|uri ref doc |
	uri := 'file:///Users/kasper/GITHUB/kasperosterbye/Microdown/doc/testMicrodown/readme.md'.
	ref := MicResourceReference  fromUri: uri.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]
