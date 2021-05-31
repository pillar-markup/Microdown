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
		'parameters',
		'caption'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #converting }
MicFigureBlock >> accept: aVisitor [
 	^ aVisitor visitFigure: self
]

{ #category : #accessing }
MicFigureBlock >> arguments [
	^ parameters
]

{ #category : #accessing }
MicFigureBlock >> arguments: aDictionary [
	parameters := aDictionary
]

{ #category : #accessing }
MicFigureBlock >> caption [
	^ String streamContents: [:st | caption do: [ :each | st nextPutAll: each text ] ] 
]

{ #category : #accessing }
MicFigureBlock >> captionElements [ 
	^ caption 
]

{ #category : #visiting }
MicFigureBlock >> closeMe [ 
	
	| dictionary |
	dictionary := OrderedDictionary new. 
	url := (ZnUrl fromString: url).
	url query ifNotNil: [ :q |
		q keysAndValuesDo: [ :k :v | dictionary at: k put: v  ] ].
	self arguments: dictionary.
	caption := self inlineParse: substring.
	
	
]

{ #category : #accessing }
MicFigureBlock >> kind [

 	^ #figure
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [

 	^ MicFigureNameOpenerDelimiter markup
]

{ #category : #accessing }
MicFigureBlock >> parameters [
	self deprecated: 'Use arguments instead' transformWith: '`@rec parameters' -> '`@rec arguments'.
	^ parameters 
]

{ #category : #accessing }
MicFigureBlock >> parameters: someParameters [
	self deprecated: 'Use arguments: instead' transformWith: '`@rec parameters: `@arg' -> '`@rec arguments: `@arg'.
	parameters := someParameters
]

{ #category : #printing }
MicFigureBlock >> printOn: aStream [
 	
 		aStream nextPut: $!;
 			nextPut: $[;
 			nextPutAll: self caption;
 			nextPut: $];
 			nextPut: $(.
		url printOn: aStream. 
		aStream nextPut: $).
 		
]
