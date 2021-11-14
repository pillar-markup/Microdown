"
I am a file reference encapsulating a file uri (`file:///path/to/some/file.md`).

I allow the host part of the file uri to be used `file://host/path/to/some/file.md`.

There are two predefined hosts:
- localhost (same as not specifying a host)
- workingdirectory (`file://workingdirectory/path/to/some/file.md`) - paths starts in working directory

It is possible to add new hosts, a primary use case is to give memory file store a way to be expressed as a file uri. See the `MicFileResourceTest` setUp, tearDown and testMemoryStoreHost.
"
Class {
	#name : #MicFileResource,
	#superclass : #MicAbsoluteResource,
	#classVars : [
		'Hosts'
	],
	#category : #'Microdown-Core'
}

{ #category : #'as yet unclassified' }
MicFileResource class >> host: hostName is: aBlock [
	self hosts at: hostName put: aBlock
]

{ #category : #'as yet unclassified' }
MicFileResource class >> hostFileReference: hostName [
	"returns a file reference for the host, or nil if no such host exists"
	^ (self hosts at: hostName ifAbsent: [ ^ nil ]) value
]

{ #category : #'as yet unclassified' }
MicFileResource class >> hosts [
	Hosts ifNil: [ 
		Hosts := Dictionary new. 
		self populateHosts ].
	^ Hosts
	
]

{ #category : #'as yet unclassified' }
MicFileResource class >> initialize [ 
	<script>
	Hosts := nil.
]

{ #category : #'as yet unclassified' }
MicFileResource class >> populateHosts [
	self host: #localhost is: [ FileSystem disk root asFileReference   ].
	self host: #workingdirectory is: [ FileSystem workingDirectory  ]
]

{ #category : #'as yet unclassified' }
MicFileResource class >> removeHost: hostName [
	self hosts removeKey: hostName ifAbsent: [  ]
]

{ #category : #converting }
MicFileResource >> asFileReference [
	"return a file reference taking the host part of uri into account"
	| hostRef |
	uri host ifNil: [ ^ uri asFileReference  ].
	hostRef := self class hostFileReference: uri host asSymbol.
	hostRef ifNil: [ ^ uri asFileReference  ].
	^ hostRef / uri path
]

{ #category : #'accessing - resources' }
MicFileResource >> loadImage [
	"return an image form from my reference"
	[ ^ ImageReadWriter formFromStream: self asFileReference binaryReadStream ]
	on: Error
	do: [ ^ nil ]
]

{ #category : #'accessing - resources' }
MicFileResource >> loadMicrodown [

	"load, parse and resolve a microdown document"
	| docString doc |
	[ docString := self asFileReference contents.
	  doc := Microdown new parse: docString.
	  ^ doc ]
	on: Error
	do: [ ^ nil ]
]

{ #category : #converting }
MicFileResource >> resolvedBy: aRoot [
	"I am an absolute file ressource, so I am already resolved"
	^ self.
]
