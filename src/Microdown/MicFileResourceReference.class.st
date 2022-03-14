"
I am a file reference encapsulating a file uri (`file:///path/to/some/file.md`).

I allow the host part of the file uri to be used `file://host/path/to/some/file.md`.

There are two predefined hosts:
- localhost (same as not specifying a host)
- workingdirectory (`file://workingdirectory/path/to/some/file.md`) - paths starts in working directory

It is possible to add new hosts, a primary use case is to give memory file store a way to be expressed as a file uri. See the `MicFileResourceTest` setUp, tearDown and testMemoryStoreHost.
"
Class {
	#name : #MicFileResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#instVars : [
		'fileSystem'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicFileResourceReference class >> fromFileRef: aFileReference [
	"return an instance of me which references aFileReference"
	^ self new
		uri: ('file://',aFileReference pathString) asZnUrl;
		fileSystem: aFileReference fileSystem 
]

{ #category : #accessing }
MicFileResourceReference >> binaryReadStream [
	^ self fileReference binaryReadStream.
]

{ #category : #accessing }
MicFileResourceReference >> contents [
	^ self fileReference contents.
]

{ #category : #accessing }
MicFileResourceReference >> fileReference [ 
	^ uri host 
		ifNil: [ self fileSystem referenceTo: self path]
		ifNotNil: [ (self class hostFileReference: uri host) / self path ].
]

{ #category : #accessing }
MicFileResourceReference >> fileSystem [

	^ fileSystem
]

{ #category : #accessing }
MicFileResourceReference >> fileSystem: anObject [

	fileSystem := anObject
]

{ #category : #testing }
MicFileResourceReference >> isFileReference [
	^ true
]

{ #category : #accessing }
MicFileResourceReference >> resolveResourceIn: aResolver [
	self uri host 
		ifNotNil: [ :hostname | |fileRef|
			fileRef := self class hostFileReference: hostname.
			fileRef ifNil: [ self error: 'unknown host' ].
			aResolver currentWorkingDirectory: fileRef
			 ].
	^ aResolver resolveAbsoluteFilePath: self
]
