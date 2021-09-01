"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png?micAnchor=figanchor&micWidth=80)`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png?micAnchor=figanchor&micWidth=80)

What is important to see is that using ? hampers to see the difference between url arguments from microdown ones such as micanchor and micwitdh. 
But if we use another character such as | `https://files.pharo.org/media/logo/logo.png|micanchor=figanchor&micwidth=80` then it breaks the external tools because they do ignore extra arguments in the expression with ? but they break on parsing |.

So we will use ? and we will prefix all the microdown specific parameters with mic. 
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

{ #category : #accessing }
MicFigureBlock >> arguments [
	^ parameters
]

{ #category : #accessing }
MicFigureBlock >> arguments: aDictionary [
	parameters := aDictionary
]

{ #category : #visiting }
MicFigureBlock >> closeMe [ 
	
	| dictionary |
	dictionary := OrderedDictionary new. 
	url := (MicResourceReference fromString: url asString).
	url query ifNotNil: [ :q |
		q keysAndValuesDo: [ :k :v | dictionary at: k put: v  ] ].
	self arguments: dictionary.
	caption := self inlineParse: substring.
	
	
]

{ #category : #testing }
MicFigureBlock >> hasCaption [ 	
	caption ifNil: [ ^ false ].
	^ true
]

{ #category : #testing }
MicFigureBlock >> isImageFile [
	"Answer whether the file name indicates an image file."

	^ url isImageFile
]

{ #category : #testing }
MicFigureBlock >> isRelativeFilePath [
	^ self url isFile and: [ (self url asString beginsWith: 'file:///') not ]
]

{ #category : #accessing }
MicFigureBlock >> kind [

 	^ #figure
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [

 	^ MicFigureNameOpenerDelimiter markup
]

{ #category : #'as yet unclassified' }
MicFigureBlock >> originUrl [
	^ self properties at: #originUrl ifAbsent: [ 
		^ url ]
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

{ #category : #accessing }
MicFigureBlock >> query [
	^ url query
]

{ #category : #accessing }
MicFigureBlock >> resolver [
	^ MicPathResolver new
]
