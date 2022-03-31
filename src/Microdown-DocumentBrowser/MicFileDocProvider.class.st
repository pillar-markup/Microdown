"
I am a provider finding microdown documents in the file of my uni. If my uri is a directory, I search recursively down that directory. If I am a single file, I just load that file into my collection.
"
Class {
	#name : #MicFileDocProvider,
	#superclass : #MicAbstractDocProvider,
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #testing }
MicFileDocProvider >> canSave [
	^ true
]

{ #category : #public }
MicFileDocProvider >> loadDirectory: aFileReference [
	"return a Document collection of the content of this directory"
	| entries files directories documents collections |
	entries := aFileReference entries.
	files := entries select: [ :file | file isFile and: [ #('md' 'mic') includes: file extension ] ].
	directories := entries select: [ :dir | dir isDirectory  ].
	files := files sort: [ :a :b | a pathString < b pathString ].
	documents := files collect: [ :entry | self loadDocumentAt: entry ].
	collections := directories collect: [:entry | self loadDirectory: entry asFileReference ].
	^ MicDocumentCollection new
		title: aFileReference basename;
		children: collections,documents;
		pathSegment: aFileReference basename;
		parent: self
]

{ #category : #accessing }
MicFileDocProvider >> loadDocumentAt: path [
	"load and resolve the document at file path"
	| doc fullDocUrl source|
	fullDocUrl := docUri withRelativeReference: path pathString.
	source := fullDocUrl asFileReference contents.
	doc := Microdown parse: source.
	doc := Microdown resolve: doc fromUri: docUri.
	^ (MicSectionBlock fromRoot: doc header: path pathString)
		documentUrl: fullDocUrl;
		propertyAt: #source put: source;
		yourself.
]

{ #category : #public }
MicFileDocProvider >> loadDocuments [ 

	| fileReference docs|
	fileReference := self docUri asFileReference.
	docs := fileReference isDirectory 
		ifTrue: [ self loadDirectory: fileReference ]
		ifFalse: [ (self loadDocumentAt: fileReference) parent: self; yourself  ].
	docs title: self docUri.
	^ docs

]

{ #category : #public }
MicFileDocProvider >> saveSection: rootSection [
	| fileRef |
	fileRef := (MicUri fromString: rootSection documentUrl printString ) asFileReference.
	fileRef writeStream 
		nextPutAll: (rootSection propertyAt: #source);
		close
]
