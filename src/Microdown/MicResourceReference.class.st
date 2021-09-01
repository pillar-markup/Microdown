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
		'url',
		'originalString'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicResourceReference class >> fromString: aString [

	^ self new 
		string: aString; 
		yourself
		
]

{ #category : #convertin }
MicResourceReference >> asFileReference [
	^ url asFileReference
]

{ #category : #resolving }
MicResourceReference >> inContextOf: aZnUrl [ 
	^ url inContextOf: aZnUrl
]

{ #category : #testing }
MicResourceReference >> isAbsolute [
	"We consider as absolute a resource reference defined as:
	'/Chapter/figures/m.mic' by opposition to 'Chapter/figures/m.mic'"

	url hasHost ifTrue: [ ^ true ].
	^ originalString first = $/
		ifTrue: [ true ]
		ifFalse: [ false. ]
	
]

{ #category : #testing }
MicResourceReference >> isFile [
	^ url isFile or: [ url hasHost not ]
]

{ #category : #testing }
MicResourceReference >> isHttp [
	^ url isHttp
]

{ #category : #testing }
MicResourceReference >> isHttps [
	^ url isHttps
]

{ #category : #testing }
MicResourceReference >> isImageFile [
	^ #('pcx' 'bmp' 'jpeg' 'xbm' 'pnm' 'ppm' 'gif' 'pam' 'jpg' 'png' 'pbm')
		includes: url path asFileReference extension asLowercase
]

{ #category : #testing }
MicResourceReference >> isRelative [
	"We consider 'chapter/figures/f.mic' as relative and any http:// to be absolute."
	
	url hasHost ifTrue: [ ^ false ].
	^ originalString first = $/
		ifFalse: [ true ]
		ifTrue: [ false ]
	
]

{ #category : #testing }
MicResourceReference >> printOn: aStream [

	url printOn: aStream
]

{ #category : #querying }
MicResourceReference >> query [
	^ url query
]

{ #category : #accessing }
MicResourceReference >> string: aString [

	originalString := aString.
	url := ZnUrl fromString: aString.
	 
]

{ #category : #accessing }
MicResourceReference >> url [ 
	^ url
]
