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
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicFileResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolveAbsoluteFilePath: self
]
