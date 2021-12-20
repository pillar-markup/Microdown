"
A MicHTTPResourceTest is a test class for testing the behavior of MicHTTPResource
"
Class {
	#name : #MicHTTPResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #'test data' }
MicHTTPResourceTest class >> githubTestData [
	^ MicResourceReference fromUri: 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #running }
MicHTTPResourceTest >> setUp [
	super setUp.
	resolver := MicUrlResolver new baseUrlString: 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorLoad [

	| uri image githubResolver |
	uri := 'nonexistingImage.png' asMicResourceUri.
	
	githubResolver := MicRelativeUrlResolver baseUrlString: self class githubTestData uri asString.
	image := uri loadImage: githubResolver.
	self assert: image isNil
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadImage [

	| uri image |
	uri := 'toplevel.png' asMicResourceUri.
	image := uri loadImage: resolver.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodown [
	| uri doc |
	uri := 'readme.md' asMicResourceUri.
	doc := uri loadMicrodown: resolver.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolves [

	| uri doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	doc := uri loadMicrodown: resolver.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self
		assert: (topLevelImageRef reference loadImage: MicUrlResolver new) height
		equals: 90
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolvesTopLevel [

	| uri doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	doc := uri loadMicrodown: resolver.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self
		assert: (topLevelImageRef reference loadImage: resolver) height
		equals: 90
]
