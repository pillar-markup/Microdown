"
I'm a silly `MicNodeTransformer`: I delete code block and replace paragraph by text. 
"
Class {
	#name : #MicNodeTransformerCodeDeleterMock,
	#superclass : #AnObsoleteMicNodeTransformer,
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #visiting }
MicNodeTransformerCodeDeleterMock >> visitCode: aCode [

	self delete
]

{ #category : #visiting }
MicNodeTransformerCodeDeleterMock >> visitParagraph: aParagraph [

	self replaceCurrentNodeBy: { MicTextBlock new substring: 'test' }
]
