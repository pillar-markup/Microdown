Class {
	#name : 'MicDummyBlogDeployer',
	#superclass : 'Object',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'as yet unclassified' }
MicDummyBlogDeployer >> deploy [
	"A super dummy md generator to be able to test"

	(FileSystem workingDirectory / 'sourceDummy') ensureDeleteAll.
	(FileSystem workingDirectory / 'sourceDummy') ensureCreateDirectory.
	FileSystem workingDirectory / 'sourceDummy' /
	 'file1.md'
	writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent1 ].
	FileSystem workingDirectory / 'sourceDummy' /
	 'file2.md'
	writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent2 ].
	FileSystem workingDirectory / 'sourceDummy' /
	 'file2.md'
	writeStreamDo: [ :st |
		st nextPutAll: MicBlogCreatorTest new fileContent3 ]
]
