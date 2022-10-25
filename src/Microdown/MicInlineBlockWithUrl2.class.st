"
My subclasses manage figures and links.

```
![Pharologo](https://files.pharo.org/media/logo/logo.png
```

![Pharologo](https://files.pharo.org/media/logo/logo.png)
"
Class {
	#name : #MicInlineBlockWithUrl2,
	#superclass : #MicInlineBlock2,
	#instVars : [
		'children',
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
MicInlineBlockWithUrl2 >> children [

	^ children
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> children: anObject [

	children := anObject
]

{ #category : #printing }
MicInlineBlockWithUrl2 >> printOn: stream [
	stream << self blockName << '{ '.
	children do: [ :ch | ch printOn: stream. stream nextPut: Character space  ].
	stream << $}.
	stream << $( << url << $)
	
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
