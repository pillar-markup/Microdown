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
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'parsing' }
MicInlineBlockWithUrl class >> parse: token stream: aTokenStream for: aParser [
	
	^ aParser parseNameUrlBlock: self from: aTokenStream token: token
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> anchor [
	| anchor |
	anchor := self arguments 
		at: #anchor 
		ifAbsent: [ nil ].
	anchor ifNil: [ anchor := self arguments at: #label ifAbsent: [ nil ] ].
	^ anchor 
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> argumentAt: aKey ifPresent: aBlock [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		ifPresent: aBlock
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> argumentAt: aKey put: value [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		put: value
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> arguments [

	^ arguments
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> bodyString [
	^ String streamContents: [ :s |
			self children do: [ :each | s nextPutAll: each bodyString ] ]
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

{ #category : 'utilities' }
MicInlineBlockWithUrl >> fileStringWithoutHostFile [
	| urlString localFileIndicator |
	urlString := url asString.
	localFileIndicator := 'file://'.
	^ (urlString beginsWith: localFileIndicator)
			ifTrue: [ urlString allButFirst: localFileIndicator size ]
			ifFalse: [ urlString ]
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> fullName [

	^ reference fullName
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasAnchor [

	^ self anchor isNotNil
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasArguments [
	^ arguments size > 0
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasCaption [

	^ children notEmpty
]

{ #category : 'testing' }
MicInlineBlockWithUrl >> hasChildren [
	^ self children notEmpty
]

{ #category : 'initialization' }
MicInlineBlockWithUrl >> initialize [
	super initialize.
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
	"Returns the figures/f.png in ![caption](figures/f.png) "
	
	^ reference
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> reference: aString [
	"Set the figures/f.png in ![caption](figures/f.png)"
	
	reference := aString
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> url [

	^ url
]

{ #category : 'accessing' }
MicInlineBlockWithUrl >> url: anObject [

	url := anObject
]
