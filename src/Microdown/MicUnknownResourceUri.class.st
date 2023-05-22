"
I am used for representing unknow uri rferences, for example `foo://bar.baz/path`
"
Class {
	#name : #MicUnknownResourceUri,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicUnknownResourceUri >> binaryReadStream [
	"Return an image with my contents (an error message)"
	| file |
	file := (FileSystem memory / 'image.png').
	PNGReadWriter putForm: self contents asText asMorph asForm onStream: file binaryWriteStream.
	^ file binaryReadStream 
]

{ #category : #accessing }
MicUnknownResourceUri >> contents [
	"Just return an error message"
	^'No resource type for `', self uriString ,'`'
]
