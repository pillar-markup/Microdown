"
HTML tags are used to delimit the start and end of elements in the markup. An HTML tag is composed of the name of the element, surrounded by angle brackets:

```
<p class=""para"">Content</p>
```

A tag could be:

- A start tag: Can have HTML attributes.
- An end tag: Has a slash after the opening angle bracket, to distinguish it from the start tag.

Note that not all elements require an **end** tag, for example the `<br>` tag.
This class contains utility methods to append HTML tags to a stream, and to manage parameters:

- #addArguments:
- #parameterAt:put:

"
Class {
	#name : #MicHTMLTag,
	#superclass : #MicHTMLBrush,
	#instVars : [
		'htmlArgumentsMap'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicHTMLTag >> addArguments: aMicInlineBlockWithUrl [

	aMicInlineBlockWithUrl hasArguments ifFalse: [ ^ self ].
	self htmlArgumentsMapDo: [ :argAssoc | 
		aMicInlineBlockWithUrl
			argumentAt: argAssoc key
			ifPresent: [ :labelString | self parameterAt: argAssoc value put: labelString ] ]
]

{ #category : #accessing }
MicHTMLTag >> close [
	"Close the receiver's tag. Note that this method does not check if the tag is opened"

	stream << $>
]

{ #category : #accessing }
MicHTMLTag >> contents [
	"Answer a <String> with receiver's output without modifying the stream position"
	
	^ stream contents
]

{ #category : #accessing }
MicHTMLTag >> htmlArgumentsMap [
	"Answer a <Dictionary> of receiver's associations between Microdown attributes and HTML attributes"
	
	^ htmlArgumentsMap
		ifNil: [ htmlArgumentsMap := self initializeArgumentsMap ]
]

{ #category : #accessing }
MicHTMLTag >> htmlArgumentsMapDo: aFullBlockClosure [ 
	"Iterate over the receiver's mapping of Microdown to HTML attributes"

	self htmlArgumentsMap associationsDo: aFullBlockClosure
]

{ #category : #initialization }
MicHTMLTag >> initializeArgumentsMap [

	^ Dictionary new
		at: 'label' put: 'class';
		at: 'size' put: 'width';
		at: 'target' put: 'target';
		at: 'rel' put: 'rel';
		yourself
]

{ #category : #accessing }
MicHTMLTag >> parameterAt: keyString put: valueString [
	"Write a parameter named keyString with valueString as value. Note that this method does not close the tag"

	stream 
		space;
		<< keyString;
		<< '="';
		<< valueString;
		<< '"'
]

{ #category : #printing }
MicHTMLTag >> printOn: aStream [

	super printOn: aStream.
	aStream << ' name: ['.
	name
		ifNotNil: [ aStream << name ].
	aStream << '] contents: ('.
	stream
		ifNotNil: [ aStream << stream contents ].
	aStream
		<< ')'
]

{ #category : #accessing }
MicHTMLTag >> with: aString [
	stream 
		nextPut: $>; 
		<< aString;
		<< '</'; 
		<< name;
		nextPut: $>
]
