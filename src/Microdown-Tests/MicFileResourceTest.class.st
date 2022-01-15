"
These tests will fail if MicHTTPResourceTest fails. I read the files from the git stores using the http based methods and stores them in local files for test of the file access.

"
Class {
	#name : #MicFileResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'emptyResolver',
		'fullResolver'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicFileResourceTest >> setUp [
	| readme image file |
	super setUp.
	emptyResolver := MicUrlResolver new.
	
	readme := (ZnEasy get: (MicHTTPResourceTest githubTestData uri + 'readme.md')) contents.
	image := ZnEasy getPng: (MicHTTPResourceTest githubTestData uri + 'toplevel.png').
	filesystem := FileSystem memory.
	fullResolver := MicUrlResolver new
		currentWorkingDirectory: filesystem workingDirectory;
		yourself.
	
	file := filesystem workingDirectory / 'readme.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: readme].
	
	file := filesystem workingDirectory / 'toplevel.png'.
	PNGReadWriter putForm: image onStream: file binaryWriteStream.
	
]

{ #category : #tests }
MicFileResourceTest >> testLoadImage [

	| ref image |
	ref := MicResourceReference fromUri: 'file:///toplevel.png'.
	image := (ref resolveResourceIn: fullResolver) asForm.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicFileResourceTest >> testLoadMicrodown [
	| uri ref doc resolvedReference |
	uri := 'file:///readme.md'.
	ref := MicResourceReference  fromUri: uri.
	resolvedReference := ref resolveResourceIn: fullResolver.
	doc := resolvedReference parseMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotCorrectImage [

	| ref |
	ref := MicResourceReference fromUri: 'file:///readme.md'.
	
	self
		should: [(ref resolveResourceIn: fullResolver) asForm]
		raise: UnrecognizedImageFormatError
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotCorrectMicrodown [

	| ref |
	ref := MicResourceReference fromUri: 'file:///toplevel.png'.
	
	self
		should: [(ref resolveResourceIn: fullResolver) parseMicrodown]
		raise: ZnInvalidUTF8
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotFoundImage [

	| ref image |
	ref := MicResourceReference fromUri: 'file:///readme.md'.
	image := (ref resolveResourceIn: emptyResolver) asForm.

	self assert: image isNil
]

{ #category : #tests }
MicFileResourceTest >> testLoadNotFoundMicrodown [
	| uri ref resolvedReference |
	uri := 'file:///readme.md'.
	ref := MicResourceReference  fromUri: uri.
	resolvedReference := ref resolveResourceIn: emptyResolver.
	
	[
		resolvedReference parseMicrodown.
		self fail
	] on: Error do: [ :e |
		self assert: e messageText equals: 'Microdown file not found' ]
]
