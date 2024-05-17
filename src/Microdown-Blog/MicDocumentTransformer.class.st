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

	^ MicInlineParser parse: '[' , aText, '](' , aLink , ')'
]

{ #category : 'accessing' }
MicDocumentTransformer >> targetDirectory [ 
	
	^ targetDirectory 
]

{ #category : 'accessing' }
MicDocumentTransformer >> targetDirectory: target [

	targetDirectory := target
]
