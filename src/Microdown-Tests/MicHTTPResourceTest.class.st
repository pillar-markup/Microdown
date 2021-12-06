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
	MicHTTPResource initialize.
	
	
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorLoad [
 	|uri ref image |
 	uri := 'nonexistingImage.png' asMicResourceUri.
 	ref := uri resolveWith: self class githubTestData.
 	image := ref loadImage.
 	self assert: image isNil
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorLoadWithHandler [
 	|uri ref image noImage|
 	noImage := 'UUUPS - No image' asMorph asForm.
 	MicHTTPResource imageNotCachedBlock:  [ noImage ].
 	uri := 'nonexistingImage.png' asMicResourceUri.
 	ref := uri resolveWith: self class githubTestData.
 	image := ref loadImage.
 	self assert: image equals: noImage.
 	"The error image was not added to the cache"
 	self deny: (MicHTTPResource imageCache includesKey: ref originalString )
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadImage [
	|uri ref image |
	uri := 'toplevel.png' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodown [
	|uri ref doc |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolves [
	|uri ref doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown.
	
	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self assert: topLevelImageRef reference loadImage height equals: 90
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolvesTopLevel [
	|uri ref doc topLevelImageRef |
	uri := 'readme.md' asMicResourceUri.
	ref := uri resolveWith: self class githubTestData.
	doc := ref loadMicrodown.
	
	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self assert: topLevelImageRef reference isResolved.
	self assert: topLevelImageRef reference loadImage height equals: 90
	
]
