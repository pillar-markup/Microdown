"
A MicHTTPResourceTest is a test class for testing the behavior of MicHTTPResource
"
Class {
	#name : #MicHTTPResourceReferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'baseUrl',
		'offlineSetting'
	],
	#category : #'Microdown-Tests-Resolution'
}

{ #category : #'test data' }
MicHTTPResourceReferenceTest class >> githubTestData [
	^ MicResourceReference fromUri: 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #running }
MicHTTPResourceReferenceTest >> setUp [
	super setUp.
	"All tests assume to be online"
	offlineSetting := Microdown offline.
	Microdown offline: false.
	baseUrl := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/'
]

{ #category : #running }
MicHTTPResourceReferenceTest >> tearDown [
	
	Microdown offline: offlineSetting.
	
	super tearDown
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testContentsSet [
	self should: [('https://someplace.irk/mydocument.md' asMicResourceReference ) 
						contents: '### Impossible']
	raise: MicResourceReferenceError 
	description: 'I should raise an error for http based resource references'
	
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testErrorNonCorrectImage [

	| ref |
	ref := MicResourceReference fromUri:  baseUrl ,'readme.md'.
	
	self
		should: [ref loadImage]
		raise: UnrecognizedImageFormatError
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testErrorNonExistingImage [

	| ref |
	ref := MicResourceReference fromUri:  baseUrl , 'nonexistingImage.png'.
	self
		should: [ref loadImage]
		raise: MicResourceReferenceError 
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testFullName [

	self assert: 'http://pharo.org/figures/foo.png' asMicResourceReference fullName equals: 'http://pharo.org/figures/foo.png'.
	
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testLoadErrorMicrodown [
	| ref |
	ref := MicResourceReference fromUri:  baseUrl ,'toplevel.png'.

	self
		should: [ref loadMicrodown]
		raise: ZnInvalidUTF8
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testLoadImage [

	| ref image |
	ref := MicResourceReference fromUri:  baseUrl , 'toplevel.png'.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testLoadMicrodown [
	| ref doc |
	ref := MicResourceReference fromUri:  baseUrl , 'readme.md'.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testLoadMicrodownResolvesUrlsRelativeToTheParent [

	| ref doc topLevelImageRef |
	ref := MicResourceReference fromUri:  baseUrl , 'readme.md'.
	doc := ref loadMicrodown.

	topLevelImageRef := doc children fourth children first.
	self assert: topLevelImageRef class equals: MicFigureBlock2.
	self
		assert: (topLevelImageRef reference loadImage) height
		equals: 90
]

{ #category : #tests }
MicHTTPResourceReferenceTest >> testLoadNonExistingMicrodown [
	| ref errorMessage|
	ref := MicResourceReference fromUri:  baseUrl , 'readmeNOT.md'.
	errorMessage := 'Could not access ', baseUrl, 'readmeNOT.md'.
	[
		ref loadMicrodown.
		self fail
	] on: Error do: [ :e |
		self assert: e messageText equals: errorMessage ]
]
