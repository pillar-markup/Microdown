"
My subclasses manage figures and links.

```
![Pharologo](https://files.pharo.org/media/logo/logo.png
```

![Pharologo](https://files.pharo.org/media/logo/logo.png)
"
Class {
	#name : 'MicInlineBlockWithUrl',
	#superclass : 'MicInlineElement',
	#instVars : [
		'children',
		'url',
		'reference',
		'arguments'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'parsing' }
MicInlineBlockWithUrl class >> parse: token stream: aTokenStream for: aParser [
	^ aParser parseNameUrlBlock: self from: aTokenStream token: token
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> anchor [
	^ self arguments 
		at: #anchor 
		ifAbsent: [ nil ] 
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> arguments [

	^ arguments
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> arguments: anObject [

	arguments := anObject
]

{ #category : 'visiting' }
MicInlineBlockWithUrl >> captionElements [
	self deprecated: 'Use children instead' transformWith: '`@rec captionElements' -> '`@rec children'.
	^ children
]

{ #category : 'visiting' }
MicInlineBlockWithUrl >> captionElements: someChildren [
	self deprecated: 'Use children: instead' transformWith: '`@rec captionElements: `@arg' -> '`@rec children: `@arg'.
	children := someChildren 
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> children [

	^ children
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> children: anObject [

	children := anObject
]

{ #category : 'visiting' }
MicInlineBlockWithUrl >> closeMe [
	"the link url - ![alt text](url) - url is allowed to have title in quotes
	(url ""title"") "

	| split title|
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	title := (split second ifNil: [ '' ]) 
		trimBoth: [:char | {$". Character space} includes: char].
	self arguments: (MicArgumentList withString: title)
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasAnchor [

	^ self anchor isNotNil
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasArguments [
	^ arguments size > 0
]

{ #category : 'initialization' }
MicInlineBlockWithUrl >> initialize [
	arguments := OrderedDictionary new.
]

{ #category : 'printing' }
MicInlineBlockWithUrl >> printOn: stream [
	stream << self blockName << '{ '.
	children do: [ :ch | ch printOn: stream. stream nextPut: Character space  ].
	stream << $}.
	stream << $( << url << $)
	
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> reference [

	^ reference
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> reference: anObject [

	reference := anObject
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> url [

	^ url
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> url: anObject [

	url := anObject
]
