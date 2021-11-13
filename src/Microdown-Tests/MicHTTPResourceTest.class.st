"
A MicHTTPResourceTest is a test class for testing the behavior of MicHTTPResource
"
Class {
	#name : #MicHTTPResourceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicHTTPResourceTest >> testLoadImage [
	|uri ref image |
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/toplevel.png'.
	ref := MicResourceReference  fromUri: uri.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodown [
	|uri ref doc |
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := MicResourceReference  fromUri: uri.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolves [
	|uri ref doc topLevelImageRef |
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := MicResourceReference  fromUri: uri.
	doc := ref loadMicrodown.
	
	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self assert: topLevelImageRef reference loadImage height equals: 90
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolvesTopLevel [
	|uri ref doc topLevelImageRef |
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := MicResourceReference  fromUri: uri.
	doc := ref loadMicrodown.
	
	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self assert: topLevelImageRef reference loadImage height equals: 90
	
]
