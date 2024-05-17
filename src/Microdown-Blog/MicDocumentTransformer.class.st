Class {
	#name : 'MicDocumentTransformer',
	#superclass : 'Object',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicDocumentTransformer class >> makeALink: aText to: aLink [

	^ MicInlineParser parse: '[' , aText, '](' , aLink , ')'
]
