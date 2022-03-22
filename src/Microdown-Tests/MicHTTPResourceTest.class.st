"
A MicHTTPResourceTest is a test class for testing the behavior of MicHTTPResource
"
Class {
	#name : #MicHTTPResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'baseUrl',
		'offlineSetting'
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
	"All tests assume to be online"
	offlineSetting := Microdown offline.
	Microdown offline: false.
	baseUrl := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #running }
MicHTTPResourceTest >> tearDown [
	
	Microdown offline: offlineSetting.
	
	super tearDown
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorNonCorrectImage [

	| ref |
	ref := MicResourceReference fromUri:  baseUrl ,'readme.md'.
	
	self
		should: [ref loadImage]
		raise: UnrecognizedImageFormatError
]

{ #category : #tests }
MicHTTPResourceTest >> testErrorNonExistingImage [

	| ref |
	ref := MicResourceReference fromUri:  baseUrl , 'nonexistingImage.png'.
	self
		should: [ref loadMicrodown]
		raise: MicResourceReferenceError 
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadErrorMicrodown [
	| ref |
	ref := MicResourceReference fromUri:  baseUrl ,'toplevel.png'.

	self
		should: [ref loadMicrodown]
		raise: ZnInvalidUTF8
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadImage [

	| ref image |
	ref := MicResourceReference fromUri:  baseUrl , 'toplevel.png'.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodown [
	| ref doc |
	ref := MicResourceReference fromUri:  baseUrl , 'readme.md'.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadMicrodownResolvesUrlsRelativeToTheParent [

	| ref doc topLevelImageRef |
	ref := MicResourceReference fromUri:  baseUrl , 'readme.md'.
	doc := ref loadMicrodown.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock.
	self
		assert: (topLevelImageRef reference loadImage) height
		equals: 90
]

{ #category : #tests }
MicHTTPResourceTest >> testLoadNonExistingMicrodown [
	| ref errorMessage|
	ref := MicResourceReference fromUri:  baseUrl , 'readmeNOT.md'.
	errorMessage := 'Could not access ', baseUrl, 'readmeNOT.md'.
	[
		ref loadMicrodown.
		self fail
	] on: Error do: [ :e |
		self assert: e messageText equals: errorMessage ]
]
