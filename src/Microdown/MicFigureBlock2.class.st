"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png  ""anchor=figanchor&width=80"")`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png ""anchor=figanchor&width=80"")

I have a resources, i.e. an object referencing either a file (in relative or absolute manner) or an Url, that refers to a given image object.

What is important to see is that there is a space between the url arguments and microdown arguments. 
"
Class {
	#name : #MicFigureBlock2,
	#superclass : #MicInlineBlockWithUrl2,
	#instVars : [
		'arguments',
		'captionElements'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicFigureBlock2 >> arguments [

	^ arguments
]

{ #category : #accessing }
MicFigureBlock2 >> arguments: anObject [

	arguments := anObject
]

{ #category : #visiting }
MicFigureBlock2 >> closeMe [
	"the link url - ![alt text](url) - url is allowed to have title in quotes
	(url ""title"") "

	| split title|
	split := url splitOnFirst: Character space.
	self reference: (MicResourceReference fromUri: split first).
	title := (split second ifNil: [ '' ]) 
		trimBoth: [:char | {$". Character space} includes: char].
	self arguments: (MicArgumentList withString: title)
]

{ #category : #printing }
MicFigureBlock2 >> printOn: aStream [
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
