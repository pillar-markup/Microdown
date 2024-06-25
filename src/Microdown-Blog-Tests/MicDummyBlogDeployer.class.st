Class {
	#name : 'MicDummyBlogDeployer',
	#superclass : 'Object',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'doit' }
MicDummyBlogDeployer >> deploy [
	"A super dummy md generator to be able to test"

	(FileSystem workingDirectory / 'sourceDummy') ensureDeleteAll.
	(FileSystem workingDirectory / 'sourceDummy') ensureCreateDirectory.
	FileSystem workingDirectory / 'sourceDummy' / 'file1.md'
		writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent1 ].
	FileSystem workingDirectory / 'sourceDummy' / 'file2.md'
		writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent2 ].
	FileSystem workingDirectory / 'sourceDummy' / 'file3.md'
		writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent3 ]
]

{ #category : 'doit' }
MicDummyBlogDeployer >> go [
	"self new go"

	self deploy.
	MicBlogCreator
		createFrom: FileSystem workingDirectory / 'sourceDummy2'
		to: self outputDirectory.
	self launchHTTPServer.
	1 seconds wait.
	self launchBrowser
]

{ #category : 'doit' }
MicDummyBlogDeployer >> launchBrowser [

	WebBrowser openOn: 'http://localhost:9090/index.html'
]

{ #category : 'doit' }
MicDummyBlogDeployer >> launchHTTPServer [

	(ZnServer defaultOn: 9090) stop.
	(ZnServer defaultOn: 9090) start.
	ZnServer default delegate: (ZnStaticFileServerDelegate new
			 directory: self outputDirectory;
			 yourself)
]

{ #category : 'doit' }
MicDummyBlogDeployer >> outputDirectory [

	^ FileSystem workingDirectory / 'outputDummy'
]
