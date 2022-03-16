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
MicHTMLTag >> parameterAt: aString put: anotherString [

	stream 
		space;
		<< aString;
		<< '="';
		<< anotherString;
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
