Class {
	#name : 'MicInlineSpaceBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'visiting' }
MicInlineSpaceBlock >> accept: aVisitor [

	aVisitor visitInlineSpace: self 
]
