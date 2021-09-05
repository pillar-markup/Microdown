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
		'originalString',
		'hasBeenResolved',
		'urlOrFileReference'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicResourceReference class >> fromString: aString [

	^ self new 
		string: aString; 
		yourself
		
]

{ #category : #converting }
MicResourceReference >> asFileReference [
	"Pay attention does not resolve the reference."
	"We do not use here the URL because 
		'chapter/figures/m.pillar' asUrl asFileReference produces an absolute file 
		>>	(File @ /chapter/figures/m.pillar) while it should be a relative one.  
		
		'chapter/figures/m.pillar' asFileReference 
		>> File @ chapter/figures/m.pillar
		"
		
	^ originalString asFileReference
]

{ #category : #testing }
MicResourceReference >> hasBeenEncodedAsFile [
	"Return true is the user did not use http.... but /tmp or tmp"
	
	
	^ hasBeenResolved 
		ifTrue: [ true ]
		ifFalse: [ urlOrFileReference isFile or: [ urlOrFileReference hasHost not ]]
		
	"When urOrFileReference holds an url isFile is expecting file:// and we do not care hence the or: "
	
	"Pay attention for the filereference branch sending isFile naively is not really working.
 
	'/tmp.png' asFileReference isFile returns false for example if the file does not existingContexts 
	
	'meta-inf.ston' asFileReference isFile returns true with the pharo-launcher because it added that file
	"
]

{ #category : #accessing }
MicResourceReference >> hasBeenResolved [

	^ hasBeenResolved
]

{ #category : #initialization }
MicResourceReference >> initialize [ 
	super initialize.
	hasBeenResolved := false.
]

{ #category : #testing }
MicResourceReference >> isAbsolute [
	"We consider as absolute a resource reference defined as:
	'/Chapter/figures/m.mic' by opposition to 'Chapter/figures/m.mic'"

	hasBeenResolved 
		ifFalse: [ urlOrFileReference hasHost ifTrue: [ ^ true ] ].
	^ originalString first = $/
		ifTrue: [ true ]
		ifFalse: [ false. ]
	
]

{ #category : #testing }
MicResourceReference >> isFile [
	
	(originalString last = $/)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #testing }
MicResourceReference >> isHttp [
	
	^ hasBeenResolved
		ifFalse: [ urlOrFileReference isHttps ]
		ifTrue: [ false ]
]

{ #category : #testing }
MicResourceReference >> isHttps [
	^ urlOrFileReference isHttps
]

{ #category : #testing }
MicResourceReference >> isImageFile [
	"Working both with resolved or not."
	^ #('pcx' 'bmp' 'jpeg' 'xbm' 'pnm' 'ppm' 'gif' 'pam' 'jpg' 'png' 'pbm')
		includes: urlOrFileReference asFileReference extension asLowercase
]

{ #category : #testing }
MicResourceReference >> isRelative [
	"We consider 'chapter/figures/f.mic' as relative and any http:// to be absolute."
	
	hasBeenResolved 
		ifFalse: [ urlOrFileReference hasHost ifTrue: [ ^ false ] ].
	^ originalString first = $/
		ifFalse: [ true ]
		ifTrue: [ false ]
	
]

{ #category : #testing }
MicResourceReference >> printOn: aStream [

	aStream nextPutAll: originalString.

]

{ #category : #querying }
MicResourceReference >> query [
	^ urlOrFileReference query
]

{ #category : #resolving }
MicResourceReference >> resolvedBy: aRoot [
	"Pay attention here we know that we have a file reference"
	
	"we should pay attention because 
	'tmp' asUrl asFileReference isRelative is false.
	So we do not resolve http....
	only /tmp and tmp"
	
	hasBeenResolved
		ifFalse: [ urlOrFileReference hasHost ifTrue: [ ^ self ]].
	
	(originalString first = $/)
		ifTrue: [ urlOrFileReference := originalString allButFirst asFileReference asResolvedBy: aRoot ]
		ifFalse: [ urlOrFileReference := FileReference fileSystem: aRoot path: (Path from: originalString) ].
	
	hasBeenResolved := true.
]

{ #category : #accessing }
MicResourceReference >> string: aString [

	originalString := aString trimBoth.
	urlOrFileReference := ZnUrl fromString: originalString.
	 
]

{ #category : #private }
MicResourceReference >> url [ 
	^ urlOrFileReference
]

{ #category : #'accessing - private' }
MicResourceReference >> urlOrReference [
	^ urlOrFileReference 
]
