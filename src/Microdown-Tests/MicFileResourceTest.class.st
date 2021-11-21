"
These tests will fail if MicHTTPResourceTest fails. I read the files from the git stores using the http based methods and stores them in local files for test of the file access.

"
Class {
	#name : #MicFileResourceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicFileResourceTest >> setUp [
	| readme image filesystem file |
	super setUp.
	
	readme := (ZnEasy get: (MicHTTPResourceTest githubTestData uri + 'readme.md')) contents.
	image := ZnEasy getPng: (MicHTTPResourceTest githubTestData uri + 'toplevel.png').
	filesystem := FileSystem memory.
	file := filesystem workingDirectory / 'readme.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: readme].
	file := filesystem workingDirectory / 'toplevel.png'.
	PNGReadWriter putForm: image onStream: file binaryWriteStream .
	MicFileResource host: #'test.memory' is: [ filesystem  ]
	
]

{ #category : #running }
MicFileResourceTest >> tearDown [
	MicFileResource removeHost: #'test.memory'.
	super tearDown 
]

{ #category : #tests }
MicFileResourceTest >> testLoadImage [
	|uri ref image |
	"uri := 'file:///Users/kasper/GITHUB/kasperosterbye/Microdown/doc/testMicrodown/toplevel.png'".
	uri := 'file://test.memory/toplevel.png'.
	ref := MicResourceReference  fromUri: uri.
	image := ref loadImage.
	self assert: image notNil.
	self assert: image height equals: 90.
	self assert: image width equals: 200
]

{ #category : #tests }
MicFileResourceTest >> testLoadMicrodown [
	|uri ref doc |
	uri := 'file://test.memory/readme.md'.
	ref := MicResourceReference  fromUri: uri.
	doc := ref loadMicrodown.
	self assert: doc children first class equals: MicHeaderBlock.
	self assert: doc children first text equals: 'Test documents' 
	
]
