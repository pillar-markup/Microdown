"
A MicHTTPResourceTest is a test class for testing the behavior of MicHTTPResource
"
Class {
	#name : #MicHTTPResourceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #'test data' }
MicHTTPResourceTest class >> githubTestData [
	^ MicResourceReference fromUri: 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #running }
MicHTTPResourceTest >> setUp [
	super setUp.
	MicHTTPResourceReference initialize.
	
	
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorLoad [

	| uri image githubResolver |
	uri := 'nonexistingImage.png' asMicResourceUri.
	
	githubResolver := MicRelativeUrlResolver baseUrl: self class githubTestData uri.
	image := uri loadImage: githubResolver.
	self assert: image isNil
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadImage [

	| uri ref image |
	uri := 'toplevel.png' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	image := ref loadImage: MicUrlResolver new.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodown [
	|uri ref doc |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown: MicUrlResolver new.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolves [

	| uri ref doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown: MicUrlResolver new.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self
		assert: (topLevelImageRef reference loadImage: MicUrlResolver new) height
		equals: 90
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolvesTopLevel [

	| uri ref doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown: MicUrlResolver new.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self
		assert: (topLevelImageRef reference loadImage: MicUrlResolver new) height
		equals: 90
]
