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
		ifTrue: [ ^ MicFileResourceReference new uri: (ZnUrl fromString: 'file://',aString) ].
	uri := ZnUrl fromString: aString.
	uri scheme
		ifNil: [ ^ MicRelativeResourceReference new relativePath: aString ].
	(uri scheme beginsWith: 'http')
		ifTrue: [ ^ MicHTTPResourceReference new uri: uri ].
	uri scheme = 'file'
		ifTrue: [ ^ MicFileResourceReference new uri: uri ].
	uri scheme = 'pharo'
		ifTrue: [ ^ MicPharoResourceReference new uri: uri ].
	^uri
	
]

{ #category : #testing }
MicResourceReference >> isRelative [
	^ false
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
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: originalString;
		nextPutAll: ')'
]

{ #category : #accessing }
MicResourceReference >> resolveResourceIn: aResolver [

	self subclassResponsibility
]

{ #category : #accessing }
MicResourceReference >> uri [
	
	self subclassResponsibility
]
