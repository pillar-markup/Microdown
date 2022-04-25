"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png  ""anchor=figanchor&width=80"")`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png ""anchor=figanchor&width=80"")

I have a resources, i.e. an object referencing either a file (in relative or absolute manner) or an Url, that refers to a given image object.

What is important to see is that there is a space between the url arguments and microdown arguments. 
"
Class {
	#name : #MicFigureBlock,
	#superclass : #MicInlineBlockWithUrl,
	#instVars : [
		'reference',
		'arguments'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #converting }
MicFigureBlock >> accept: aVisitor [
 	^ aVisitor visitFigure: self
]

{ #category : #accessing }
MicFigureBlock >> alt [
  ^ self arguments at: #alt ifAbsent: ['']
]

{ #category : #accessing }
MicFigureBlock >> alt: aString [
    self arguments at: #alt put: aString
]

{ #category : #accessing }
MicFigureBlock >> anchor [
	^self arguments at: #anchor 
	ifAbsent: [ nil ] 
]

{ #category : #accessing }
MicFigureBlock >> argumentAt: aKey [

	^ self arguments at: aKey
]

{ #category : #accessing }
MicFigureBlock >> argumentAt: aKey ifPresent: aBlock [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		ifPresent: aBlock
]

{ #category : #accessing }
MicFigureBlock >> argumentAt: aKey put: anObject [

	self arguments at: aKey put: anObject
]

{ #category : #accessing }
MicFigureBlock >> arguments [
	^ arguments
]

{ #category : #accessing }
MicFigureBlock >> arguments: aDictionary [
	arguments := aDictionary
]

{ #category : #visiting }
MicFigureBlock >> closeMe [
	"the link url - ![alt text](url) - url is allowed to have title in quotes
	(url ""title"") "
	| split title|
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	title := (split second ifNil: [ '' ]) 
		trimBoth: [:char | {$". Character space} includes: char].
	self arguments: (MicArgumentsSplitter withString: title).
	self captionElements: (self inlineParse: substring).
	self children: captionElements
]

{ #category : #testing }
MicFigureBlock >> hasAnchor [
	^self anchor isNotNil
]

{ #category : #accessing }
MicFigureBlock >> hasArguments [
	"Answer <true> if the receiver contain at least 1 argument"
	
	^ arguments notEmpty
]

{ #category : #testing }
MicFigureBlock >> hasCaption [ 	
	^ captionElements notNil 
]

{ #category : #testing }
MicFigureBlock >> hasChildren [
	^ self children notEmpty.
]

{ #category : #accessing }
MicFigureBlock >> initialize [

	super initialize.
	arguments := OrderedDictionary new
]

{ #category : #accessing }
MicFigureBlock >> kind [
	self flag: #todo. 
	"remove me"
 	^ #figure
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [

 	^ FigureNameOpenerMarkup
]

{ #category : #accessing }
MicFigureBlock >> originUrl [
	^ self properties at: #originUrl ifAbsent: [ 
		^ url ]
]

{ #category : #printing }
MicFigureBlock >> printOn: aStream [
 		aStream nextPut: $!;
 			nextPut: $[;
 			nextPutAll: self caption;
 			nextPut: $];
 			nextPut: $(.
		aStream nextPutAll: (
			url
				ifNotNil: [ url. ] 
				ifNil: [ String empty ]).		 
		aStream nextPut: $).
 		
]

{ #category : #accessing }
MicFigureBlock >> reference [

	^ reference
]

{ #category : #accessing }
MicFigureBlock >> reference: anObject [

	reference := anObject
]

{ #category : #accessing }
MicFigureBlock >> resources [ 

	^ url 
]

{ #category : #accessing }
MicFigureBlock >> resources: micResources [

	url := micResources
]
