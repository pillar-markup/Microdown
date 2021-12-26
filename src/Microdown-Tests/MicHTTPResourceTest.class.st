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
MicHTTPResourceTest >> testErrorNonCorrectImage [

	| uri |
	uri := 'readme.md' asMicResourceUri.
	
	self
		should: [(uri resolveResourceIn: resolver) asForm]
		raise: UnrecognizedImageFormatError
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorNonExistingImage [

	| uri image |
	uri := 'nonexistingImage.png' asMicResourceUri.
	
	image := (uri resolveResourceIn: resolver) asForm.
	self assert: image isNil
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadErrorMicrodown [
	| uri |
	uri := 'toplevel.png' asMicResourceUri.

	self
		should: [uri loadMicrodown: resolver]
		raise: ZnInvalidUTF8
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
MicHTTPResourceTest >> testLoadMicrodownResolvesUrlsRelativeToTheParent [

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
MicHTTPResourceTest >> testLoadNonExistingMicrodown [
	| uri doc |
	uri := 'readmeNOT.md' asMicResourceUri.
	
	[
		uri loadMicrodown: resolver.
		self fail
	] on: Error do: [ :e |
		self assert: e messageText equals: 'Microdown file not found' ]
]
