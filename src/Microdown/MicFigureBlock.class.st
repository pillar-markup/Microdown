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
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicFigureBlock class >> closingDelimiter [

 	^ NameCloserUrlOpener
]

{ #category : #accessing }
MicFigureBlock class >> openingDelimiter [

 	^ FigureNameOpenerMarkup
]

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
	^ self arguments 
		at: #anchor 
		ifAbsent: [ nil ] 
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
	self arguments: (MicArgumentList withString: title).
	self captionElements: (self inlineParse: substring).
	self children: captionElements
]

{ #category : #'to be removed' }
MicFigureBlock >> figurePath [
	"this is a hack waiting for the resolution of resource references"
	"when we have file://figures/foo.png we want to have figures/foo.png "
	
	^ (self url asString beginsWith: 'file://')
		ifTrue: [ (self url allButFirst: 'file://' size) substrings at: 1 ]
		ifFalse: [ self url substrings at: 1  ] 
	
	
]

{ #category : #printing }
MicFigureBlock >> fullName [

	^ reference fullName
]

{ #category : #testing }
MicFigureBlock >> hasAnchor [

	^ self anchor isNotNil
]

{ #category : #testing }
MicFigureBlock >> hasCaption [
	
	^ captionElements notNil 
]

{ #category : #testing }
MicFigureBlock >> hasChildren [
	^ self children notEmpty
]

{ #category : #accessing }
MicFigureBlock >> kind [
	self flag: #todo. 
	"remove me"
 	^ #figure
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [
	^ self class openingDelimiter
]

{ #category : #accessing }
MicFigureBlock >> originUrl [
	^ self properties 
		at: #originUrl 
		ifAbsent: [ url halt]
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
				ifNotNil: [ url ] 
				ifNil: [ String empty ]).		 
		aStream nextPut: $).
 		
]
