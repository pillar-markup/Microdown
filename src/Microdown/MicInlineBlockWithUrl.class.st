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
		'url',
		'caption'
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

{ #category : #accessing }
MicInlineBlockWithUrl >> caption [
	^ String streamContents: [:st | caption do: [ :each | st nextPutAll: each text ] ] 
]

{ #category : #visiting }
MicInlineBlockWithUrl >> captionElements [ 
	^ caption 
]

{ #category : #accessing }
MicInlineBlockWithUrl >> closingDelimiter [

 	^ MicURLCloserDelimiter markup
]

{ #category : #'instance creation' }
MicInlineBlockWithUrl >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: Array empty withURL: aURL)
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url: anUrl [
	url := anUrl
]
