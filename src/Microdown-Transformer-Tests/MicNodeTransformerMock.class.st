Class {
	#name : #MicNodeTransformerMock,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'transformer'
	],
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #visiting }
MicNodeTransformerMock >> visitCode: aCode [

	self delete
]

{ #category : #visiting }
MicNodeTransformerMock >> visitParagraph: aParagraph [

	self replace: { MicTextBlock new substring: 'test' }
]
