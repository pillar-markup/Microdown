"
These tests will fail if MicHTTPResourceTest fails. I read the files from the git stores using the http based methods and stores them in local files for test of the file access.

"
Class {
	#name : #MicFileResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicFileResourceTest >> setUp [
	| readme image file |
	super setUp.
	
	readme := (ZnEasy get: (MicHTTPResourceTest githubTestData uri + 'readme.md')) contents.
	image := ZnEasy getPng: (MicHTTPResourceTest githubTestData uri + 'toplevel.png').
	filesystem := FileSystem memory.
	
	file := filesystem workingDirectory / 'readme.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: readme].
	
	file := filesystem workingDirectory / 'toplevel.png'.
	PNGReadWriter putForm: image onStream: file binaryWriteStream .
	
]

{ #category : #tests }
MicFileResourceTest >> testLoadImage [
	|uri ref image |
	uri := 'file:///toplevel.png'.
	ref := MicResourceReference  fromUri: uri.
	image := ImageReadWriter formFromStream: (ref resolvedBy: filesystem root) binaryReadStream.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicFileResourceTest >> testLoadMicrodown [
	|uri ref doc fileReference |
	uri := 'file:///readme.md'.
	ref := MicResourceReference  fromUri: uri.
	fileReference := ref resolvedBy: filesystem root.
	doc := Microdown parse: fileReference contents.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]
