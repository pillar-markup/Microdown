"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png? anchor=figanchor&width=80)`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png anchor=figanchor&width=80)

I have a resources, i.e. an object referencing either a file (in relative or absolute manner) or an Url, that refers to a given image object.

What is important to see is that there is a space between the url arguments and microdown arguments. 
"
Class {
	#name : #MicFigureBlock,
	#superclass : #MicInlineBlockWithUrl,
	#instVars : [
		'parameters',
		'reference'
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

	"we used this circumvoluted way to use the parsing on arguments provided by the URL parser,
	even in case of file. so the user can express tmp/figures/goo.png?width=90&anchor=foo"

	| split |
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	self arguments:
		(MicArgumentsSplitter withString: (split second ifNil: [ '' ])) arguments.
	self captionElements: (self inlineParse: substring).
	self children: captionElements
]

{ #category : #accessing }
MicFigureBlock >> hasArguments [

	^ parameters keys isNotEmpty
]

{ #category : #testing }
MicFigureBlock >> hasCaption [ 	
	^ captionElements notNil 
]

{ #category : #testing }
MicFigureBlock >> isImageFile [
	"Answer whether the file name indicates an image file."

	^ url isImage
]

{ #category : #accessing }
MicFigureBlock >> kind [
	self flag: #todo. 
	"remove me"
 	^ #figure
]

{ #category : #accessing }
MicFigureBlock >> openingDelimiter [

 	^ MicFigureNameOpenerDelimiter markup
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
		aStream nextPutAll: url. 
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
