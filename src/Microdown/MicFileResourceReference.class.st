"
I am a file reference encapsulating a file URI (`file:/path/to/some/file.md`).

## Ambiguity of URI
Inside the pharo image, string-based file references are ambiguous. `/path/to/some/file.md` could mean a file on disk, or a file in the memory file system. 

I will assume it is disk-based unless told otherwise. 

However, I can be given an explicit filesystem for disambiguation using the `filesystem:` method. 

## Creation from Pharo FileReference
Normally, instances of `MicResourceReference` are created using `MicResourceReference fromUri: uriString`.

You can get an instance of me from a Pharo `FileReference` using `MicFileResourceReference fromFileRef: aFileRef`. The filesystem of `aFileRef` is taken into account. 

## Examples
The test class `MicFileResourceReferenceTest` has two tests `testLoadImage` and `testLoadMicrodown` that show how to use me.
"
Class {
	#name : 'MicFileResourceReference',
	#superclass : 'MicAbsoluteResourceReference',
	#instVars : [
		'filesystem'
	],
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'instance creation' }
MicFileResourceReference class >> fromFileRef: aFileReference [
	"return an instance of me which references aFileReference"
	| znUrl |
	znUrl := aFileReference asZnUrl.
	aFileReference isDirectory 
		ifTrue: [ znUrl addPathSegment: $/ "Yes, a Character not a string" ].
	^ self new
		uri: znUrl;
		filesystem: aFileReference fileSystem 
]

{ #category : 'instance creation' }
MicFileResourceReference class >> handlesUriScheme: scheme [
	^ scheme = 'file'
]

{ #category : 'accessing' }
MicFileResourceReference >> binaryReadStream [
	[^ self fileReference binaryReadStream]
	on: FileDoesNotExistException 
	do: [ :error | 
		error resignalAs: (MicResourceReferenceError new messageText: 'Microdown file not found')  ]
]

{ #category : 'testing' }
MicFileResourceReference >> canSave [
	"return true if I implement contents: "
	^true
]

{ #category : 'accessing' }
MicFileResourceReference >> contents [
	[^ self fileReference isDirectory ifTrue: [''] ifFalse: [self fileReference contents] ]
	on: FileDoesNotExistException 
	do: [ :error | 
		error resignalAs: (MicResourceReferenceError new messageText: 'The Microdown file at  "', self fullName , '" are not found')  ]
]

{ #category : 'accessing' }
MicFileResourceReference >> contents: aString [
	"write the contents of a string to my file"
	|fileRef|
	fileRef := self fileReference.
	fileRef ensureDelete.
	self fileReference writeStreamDo: [ :stream | stream nextPutAll: aString ].
]

{ #category : 'accessing' }
MicFileResourceReference >> fileReference [ 
	^ self filesystem referenceTo: self path
]

{ #category : 'accessing' }
MicFileResourceReference >> filesystem [
	^ filesystem
]

{ #category : 'accessing' }
MicFileResourceReference >> filesystem: anObject [

	filesystem := anObject
]

{ #category : 'accessing' }
MicFileResourceReference >> fullName [ 
	^ self path
]

{ #category : 'initialization' }
MicFileResourceReference >> initialize [
	super initialize.
	filesystem := FileSystem disk.
]

{ #category : 'accessing' }
MicFileResourceReference >> isDirectory [
	^ self fileReference isDirectory 
]

{ #category : 'testing' }
MicFileResourceReference >> isMicrodownResourceFileReference [
	^ true
]

{ #category : 'accessing' }
MicFileResourceReference >> loadChildren [
	"return a collection of MicResourceReferences if I am a directory, empty if I am not a directory"
	self isDirectory ifFalse: [ ^ #() ].
	^ self fileReference children
		select: [ :child | child isDirectory or: [ #(md mic) includes: child extension  ] ] 
		thenCollect: [ :child | child asMicResourceReference ]
]
