Class {
	#name : 'MicDummyBlogDeployer',
	#superclass : 'Object',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'navigating' }
MicDummyBlogDeployer class >> go [
	<script>
	self new go
]

{ #category : 'doit' }
MicDummyBlogDeployer >> deploy [
	"A super dummy md generator to be able to test"

	| ressources |
	ressources := MicFileTestResources new.
	(FileSystem workingDirectory / self sourceFolder) ensureDeleteAll.
	(FileSystem workingDirectory / self sourceFolder)
		ensureCreateDirectory.
	FileSystem workingDirectory / self sourceFolder / 'file1.md'
		writeStreamDo: [ :st |
		st nextPutAll: ressources generateFilesystemExample1 contents ].
	FileSystem workingDirectory / self sourceFolder / 'file2.md'
		writeStreamDo: [ :st |
		st nextPutAll: ressources generateFilesystemExample2 contents ].
	FileSystem workingDirectory / self sourceFolder / 'file3.md'
		writeStreamDo: [ :st |
		st nextPutAll: ressources generateFilesystemExample3 contents ]
]

{ #category : 'doit' }
MicDummyBlogDeployer >> go [
	"self new go"

	self deploy.
	MicBlogCreator
		createFrom: FileSystem workingDirectory / self sourceFolder
		to: self outputDirectory
		withRoot: 'root'.
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

{ #category : 'doit' }
MicDummyBlogDeployer >> sourceFolder [

	^ 'sourceDummy3'
]
