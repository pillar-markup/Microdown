Class {
	#name : 'MicDocumentTransformer',
	#superclass : 'Object',
	#instVars : [
		'targetDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicDocumentTransformer class >> makeALink: aText to: aLink [

	| text link |

	(aText isNil or: aText isEmpty ) ifTrue: [ text := 'Undefined' ] ifFalse: [ text := aText ].
	(aLink isNil or: aLink isEmpty ) ifTrue: [ link := 'Undefined' ] ifFalse: [ link := aLink ].

	 ^ MicInlineParser parse: '[' , text , '](' , link , ')'
]

{ #category : 'accessing' }
MicDocumentTransformer >> targetDirectory [ 
	
	^ targetDirectory 
]

{ #category : 'accessing' }
MicDocumentTransformer >> targetDirectory: target [

	targetDirectory := target
]
