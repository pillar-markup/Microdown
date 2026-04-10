Class {
	#name : 'MicInlineCommentBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicInlineCommentBlock class >> closingDelimiter [

 	^ self shouldNotImplement
]

{ #category : 'accessing' }
MicInlineCommentBlock class >> openingDelimiter [

 	^ CommentedLineMarkup 
]

{ #category : 'visiting' }
MicInlineCommentBlock >> accept: aVisitor [
	"For now do nothing"
	
]
