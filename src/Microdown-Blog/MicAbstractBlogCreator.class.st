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
	
	(aText isNil or: aText isEmpty)
		ifTrue: [ text := 'Undefined' ]
		ifFalse: [ text := aText ].
		
	(aLink isNil or: aLink isEmpty)
		ifTrue: [ link := 'Undefined' ]
		ifFalse: [ link := aLink ].

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
