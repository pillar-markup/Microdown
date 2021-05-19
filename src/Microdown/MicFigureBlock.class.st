"
I am a **figure**.

My syntax is: `!\[my name](url|label=value1&caption=value2&width=value3)`

My arguments are:
- substring (_from superclass `#MicAbstractInlineBlockWithUrl`_): it's my printed name
- url
- parameters: a `#ZnMultiValueDictionary` which collect all keys and values
"
Class {
	#name : #MicFigureBlock,
	#superclass : #MicInlineBlockWithUrl,
	#instVars : [
		'parameters'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #converting }
MicFigureBlock >> accept: aVisitor [
 	^ aVisitor visitFigure: self
]

{ #category : #converting }
MicFigureBlock >> asPillar [
	| aPRFigure |
	aPRFigure := super asPillar.
	^ aPRFigure label: self substring; parameters: self parameters; yourself
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [

 	^ MicFigureNameOpenerDelimiter markup
]

{ #category : #accessing }
MicFigureBlock >> parameters [
	^ parameters 
]

{ #category : #accessing }
MicFigureBlock >> parameters: someParameters [
	parameters := someParameters
]

{ #category : #printing }
MicFigureBlock >> printOn: aStream [
 	(self kind == #basic) 
 		ifTrue: [ aStream nextPutAll: self substring ] 
 		ifFalse: [ 
 			| contents |
 			contents := children 
 				ifEmpty: [ self substring ] 
 				ifNotEmpty: [ self childrenPrintOn ].
 			aStream nextPut: $!;
 				nextPut: $[;
 				nextPutAll: contents;
 				nextPut: $];
 				nextPut: $(.
 				url printOn: aStream.
 			parameters 
 				ifNotEmpty: [ | params |
 					params := ''.
 					aStream nextPut: $|.
 					parameters keysAndValuesDo: [ :key :value | params := params , key asString  , '=' , value asString , '&'  ].
 					params byteAt: params size put: Character space.
 					aStream nextPutAll: params].
 			aStream nextPut: $) 
 		]
]

{ #category : #transformation }
MicFigureBlock >> urlTransformation [
	| argumentsSplitter |
	argumentsSplitter := MicArgumentsSplitter withStream: self url readStream.
	self url: (ZnUrl fromString: argumentsSplitter name).
	self parameters: argumentsSplitter arguments
]
