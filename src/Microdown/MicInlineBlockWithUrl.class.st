"
My subclasses manage figures and links.

```
![Pharologo](https://files.pharo.org/media/logo/logo.png
```

![Pharologo](https://files.pharo.org/media/logo/logo.png)
"
Class {
	#name : #MicInlineBlockWithUrl,
	#superclass : #MicInlineElement,
	#instVars : [
		'url'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #'instance creation' }
MicInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL [
	^ self new 
		start: aStartInteger; 
		end: anEndInteger; 
		substring: aString; 
		children: aChildren; 
		cleanSubstring; 
		url: aURL;
		closeMe; 
		yourself
]

{ #category : #'instance creation' }
MicInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: Array empty withURL: aURL)
]

{ #category : #transformation }
MicInlineBlockWithUrl >> caption [ 
	^ self substring
]

{ #category : #accessing }
MicInlineBlockWithUrl >> closingDelimiter [

 	^ MicURLCloserDelimiter markup
]

{ #category : #printing }
MicInlineBlockWithUrl >> printOn: aStream [
	(self kind == #basic) 
		ifTrue: [ aStream nextPutAll: self substring ] 
		ifFalse: [ 
			| contents |
			contents := children 
				ifEmpty: [ self substring ] 
				ifNotEmpty: [ self childrenPrintOn ].
			aStream nextPut: $[;
				nextPutAll: contents;
				nextPut: $];
				nextPut: $(.
			url printOn: aStream.
			aStream nextPut: $) 
		]
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url: anURL [
	url := anURL
]
