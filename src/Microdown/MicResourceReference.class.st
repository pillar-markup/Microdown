"
I represent a file reference or url reference.

Here are the cases that we should handle

- external links
- figures
- inputfiles

For external links we can accept an URL that will be considered as absolute path to the resources http://server/m.mic.
For inputfile and figures we can accept

- an Url http://server/m.mic or http://server/m.png
- a relative path e.g., figures/m.png

## Implementation

url is misleading as an instance variable names since it can be either an url or a file reference.

## Warning

This is class is under heavy development. 
Some API will be dropped. Right now we just wrapped an URL to get the tests passing but we will revisit all the points.

Note that 

```
'file:///toto.png' asUrl isAbsolute 
>>> false
'file://toto.png' asUrl isAbsolute 
>>> true
```
So this is counter intuitive from a simple look.

"
Class {
	#name : #MicResourceReference,
	#superclass : #Object,
	#instVars : [
		'originalString'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicResourceReference class >> fromUri: aString [
	| uri |
	(aString beginsWith: '/')
		ifTrue: [ ^ MicFileResource new uri: (ZnUrl fromString: 'file://',aString) ].
	uri := ZnUrl fromString: aString.
	uri scheme
		ifNil: [ ^ MicRelativeResource new relativePath: aString ].
	(uri scheme beginsWith: 'http')
		ifTrue: [ ^ MicHTTPResource new uri: uri ].
	uri scheme = 'file'
		ifTrue: [ ^ MicFileResource new uri: uri ].
	uri scheme = 'pharo'
		ifTrue: [ ^ MicPharoResource new uri: uri ].
	^uri
	
]

{ #category : #'as yet unclassified' }
MicResourceReference class >> workingDirectoryReference [
	^ self fromUri: FileSystem workingDirectory asUrl asString
]

{ #category : #testing }
MicResourceReference >> isFile [
	"answer if the resource is a file (as opposed to a directory)"
	(self path last = $/)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #testing }
MicResourceReference >> isImage: aPath [
	"makes a guess if path referes to an image"
	^ #( 'pcx' 'bmp' 'jpeg' 'xbm' 'pnm' 'ppm' 'gif' 'pam' 'jpg' 'png'
	     'pbm' ) includes: (aPath copyAfterLast: $.) asLowercase
]

{ #category : #testing }
MicResourceReference >> isResolved [ 
	self subclassResponsibility 
]

{ #category : #'accessing - resources' }
MicResourceReference >> loadImage [
	"return an image form from my reference"
	self subclassResponsibility 
]

{ #category : #'accessing - resources' }
MicResourceReference >> loadMicrodown [
	"load, parse and resolve a microdown document"
	self subclassResponsibility 
]

{ #category : #accessing }
MicResourceReference >> originalString [
	
	^ originalString 
]

{ #category : #accessing }
MicResourceReference >> originalString: anObject [

	originalString := anObject
]

{ #category : #private }
MicResourceReference >> path [
	"return the path part of my reference (leave out http: or file:)"
	self subclassResponsibility 
]

{ #category : #printing }
MicResourceReference >> printOn: aStream [
	aStream nextPutAll: originalString 
]
