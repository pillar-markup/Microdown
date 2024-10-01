Class {
	#name : 'MicInlineSpaceBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'parsing' }
MicInlineSpaceBlock class >> parse: delimiter stream: aTokenStream for: aParser [

	^ self new
]

{ #category : 'visiting' }
MicInlineSpaceBlock >> accept: aVisitor [

	aVisitor visitInlineSpace: self 
]
