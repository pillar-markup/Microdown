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
		'reference',
		'arguments'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #parsing }
MicInlineBlockWithUrl2 class >> parse: token stream: aTokenStream for: aParser [
	^ aParser parseNameUrlBlock: self from: aTokenStream token: token
]

{ #category : #testing }
MicInlineBlockWithUrl2 >> anchor [
	^ self arguments 
		at: #anchor 
		ifAbsent: [ nil ] 
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> arguments [

	^ arguments
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> arguments: anObject [

	arguments := anObject
]

{ #category : #visiting }
MicInlineBlockWithUrl2 >> captionElements [
	self deprecated: 'Use children instead' transformWith: '`@rec captionElements' -> '`@rec children'.
	^ children
]

{ #category : #visiting }
MicInlineBlockWithUrl2 >> captionElements: someChildren [
	self deprecated: 'Use children: instead' transformWith: '`@rec captionElements: `@arg' -> '`@rec children: `@arg'.
	children := someChildren 
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> children [

	^ children
]

{ #category : #accessing }
MicInlineBlockWithUrl2 >> children: anObject [

	children := anObject
]

{ #category : #visiting }
MicInlineBlockWithUrl2 >> closeMe [
	"the link url - ![alt text](url) - url is allowed to have title in quotes
	(url ""title"") "

	| split title|
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	title := (split second ifNil: [ '' ]) 
		trimBoth: [:char | {$". Character space} includes: char].
	self arguments: (MicArgumentList withString: title)
]

{ #category : #testing }
MicInlineBlockWithUrl2 >> hasAnchor [

	^ self anchor isNotNil
]

{ #category : #testing }
MicInlineBlockWithUrl2 >> hasArguments [
	^ arguments size > 0
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
