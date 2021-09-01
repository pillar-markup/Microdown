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

{ #category : #accessing }
MicResourceReference >> string: aString [

	originalString := aString.
	url := ZnUrl fromString: aString.
	 
]

{ #category : #accessing }
MicResourceReference >> url [ 
	^ url
]
