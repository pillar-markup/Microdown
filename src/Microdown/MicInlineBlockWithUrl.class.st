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
		'parser',
		'captionElements',
		'arguments',
		'reference'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #private }
MicInlineBlockWithUrl class >> fileStringWithoutHostFile: aString [
	| localFileIndicator |
	localFileIndicator := 'file://'.
	^ (aString beginsWith: localFileIndicator)
			ifTrue: [ aString allButFirst: localFileIndicator size ]
			ifFalse: [ aString ]
]

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
MicInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren withURL: aURL withParser: aParser [
	^ self new 
		start: aStartInteger; 
		end: anEndInteger; 
		substring: aString; 
		children: aChildren; 
		cleanSubstring; 
		url: aURL;
		parser: aParser;
		closeMe; 
		yourself
]

{ #category : #'instance creation' }
MicInlineBlockWithUrl class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withURL: aURL [
	^ (self from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: Array empty withURL: aURL)
]

{ #category : #accessing }
MicInlineBlockWithUrl >> argumentAt: aKey [

	^ self arguments at: aKey
]

{ #category : #accessing }
MicInlineBlockWithUrl >> argumentAt: aKey ifPresent: aBlock [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		ifPresent: aBlock
]

{ #category : #accessing }
MicInlineBlockWithUrl >> argumentAt: aKey put: anObject [

	self arguments at: aKey put: anObject
]

{ #category : #accessing }
MicInlineBlockWithUrl >> arguments [
	^ arguments
]

{ #category : #accessing }
MicInlineBlockWithUrl >> arguments: aDictionary [
	arguments := aDictionary
]

{ #category : #accessing }
MicInlineBlockWithUrl >> caption [
	^ String streamContents: [:st | self captionElements do: [ :each | st nextPutAll: each text ] ] 
]

{ #category : #visiting }
MicInlineBlockWithUrl >> captionElements [ 
	^ captionElements ifNil: [ OrderedCollection new ]
]

{ #category : #visiting }
MicInlineBlockWithUrl >> captionElements: aCollection [ 
	captionElements := aCollection
]

{ #category : #accessing }
MicInlineBlockWithUrl >> closingDelimiter [

 	^ URLCloserMarkup
]

{ #category : #accessing }
MicInlineBlockWithUrl >> fileStringWithoutHostFile [
	^ self class fileStringWithoutHostFile: url asString
]

{ #category : #accessing }
MicInlineBlockWithUrl >> hasArguments [
	"Answer <true> if the receiver contain at least 1 argument"
	
	^ arguments notEmpty
]

{ #category : #accessing }
MicInlineBlockWithUrl >> initialize [

	super initialize.
	arguments := OrderedDictionary new
]

{ #category : #accessing }
MicInlineBlockWithUrl >> parser [ 
	^ parser
]

{ #category : #accessing }
MicInlineBlockWithUrl >> parser: aParser [
	parser := aParser
]

{ #category : #printing }
MicInlineBlockWithUrl >> printOn: aStream [
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
MicInlineBlockWithUrl >> reference [

	^ reference
]

{ #category : #accessing }
MicInlineBlockWithUrl >> reference: anObject [

	reference := anObject
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
MicInlineBlockWithUrl >> url: anURL [

	url := anURL
]
