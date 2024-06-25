Class {
	#name : 'MicAbstractBlogCreator',
	#superclass : 'Object',
	#instVars : [
		'targetDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'make' }
MicAbstractBlogCreator >> makeALink: aText to: aLink [

	| text link |
	text := aText.
	text isNil
		ifTrue: [ text := 'Undefined' ]
		ifFalse: [ text isEmpty ifTrue: [ text := 'Undefined' ]].

	link := aLink.
	link isNil
		ifTrue: [ link := 'Undefined' ]
		ifFalse: [ link isEmpty ifTrue: [ link := 'Undefined' ]].
		
	^ (MicInlineParser parse: '[' , text , '](' , link , ')') first
]

{ #category : 'accessing' }
MicAbstractBlogCreator >> targetDirectory [ 
	
	^ targetDirectory 
]

{ #category : 'accessing' }
MicAbstractBlogCreator >> targetDirectory: target [

	targetDirectory := target
]
