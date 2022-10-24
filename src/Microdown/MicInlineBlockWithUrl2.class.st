"
My subclasses manage figures and links.

```
![Pharologo](https://files.pharo.org/media/logo/logo.png
```

![Pharologo](https://files.pharo.org/media/logo/logo.png)
"
Class {
	#name : #MicInlineBlockWithUrl2,
	#superclass : #MicInlineElement2,
	#instVars : [
		'url',
		'reference'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #parsing }
MicInlineBlockWithUrl2 class >> parse: token stream: aTokenStream for: aParser [
	^ aParser parseNameUrlBlock: self from: aTokenStream token: token
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> captionElements [ 
	"caption is an old mistake for the part between the square brackets [caption](url)"
	^ children
]

{ #category : #printing }
MicInlineBlockWithUrl2 >> printOn: aStream [
	| contents |
	contents := children
		            ifEmpty: [ self substring ]
		            ifNotEmpty: [ self childrenPrintOn ].
	aStream
		nextPut: $[;
		nextPutAll: contents;
		nextPut: $];
		nextPut: $(.
		aStream nextPutAll: url. 
	aStream nextPut: $)
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> reference [

	^ reference
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> reference: anObject [

	reference := anObject
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url [

	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> url: anObject [

	url := anObject
]
