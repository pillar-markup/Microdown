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
	#classVars : [
		'Hosts'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicFileResourceReference class >> fromFileRef: aFileReference [
	"return an instance of me which references aFileReference"
	| host micRef |
	aFileReference fileSystem isDiskFileSystem
		ifTrue:[ ^ self new uri: ('file://',aFileReference pathString ) asZnUrl].
	"fileReference is a memory filesystem"
	host := self hostOf: aFileReference.
	host ifNil: [
		host := #'memory.default'.
		self host: host is: aFileReference fileSystem].
	micRef := self new uri: ('file://', host, aFileReference pathString ) asZnUrl .
	^ micRef
]

{ #category : #'host resolution' }
MicFileResourceReference class >> host: hostName is: aFileReference [ 
	self hosts at: hostName put: aFileReference

]

{ #category : #'host resolution' }
MicFileResourceReference class >> hostFileReference: hostName [ 
	"returns a file reference for the host, or nil if no such host exists"
	^ self hosts at: hostName ifAbsent: [ ^ nil ] 

]

{ #category : #'host resolution' }
MicFileResourceReference class >> hostOf: aFileReference [
	| host |
	host := self hosts associations 
		detect: [ :assoc | assoc value = aFileReference fileSystem ]
		ifNone: [ ^ nil ].
	^ host key
]

{ #category : #'host resolution' }
MicFileResourceReference class >> hosts [ 
	Hosts ifNil: [ 
		Hosts := Dictionary new. 
		self populateHosts ].
	^ Hosts
]

{ #category : #'class initialization' }
MicFileResourceReference class >> initialize [  
	<script>
	Hosts := nil.

]

{ #category : #'host resolution' }
MicFileResourceReference class >> populateHosts [ 
	self host: #localhost is: FileSystem disk root asFileReference .
	self host: #workingdirectory is: FileSystem disk workingDirectory

]

{ #category : #'host resolution' }
MicFileResourceReference class >> removeHost: hostName [ 
	self hosts removeKey: hostName ifAbsent: [  ]

]

{ #category : #accessing }
MicFileResourceReference >> contents [
	^ uri host 
		ifNil: [ self path asFileReference contents]
		ifNotNil: [ ((self class hostFileReference: uri host) / self path) contents ].
]

{ #category : #loading }
MicFileResourceReference >> loadMicrodown [
	"I am an absolute reference, so I should be able to load completely"
	|doc|
	doc := Microdown parse: self contents.
	doc := Microdown resolve: doc fromUri: uri.
	^ doc
]

{ #category : #accessing }
MicFileResourceReference >> resolveResourceIn: aResolver [
	self error: 'Check the uri for host, and set resolvers working directory if host is not nil'.
	^ aResolver resolveAbsoluteFilePath: self
]
