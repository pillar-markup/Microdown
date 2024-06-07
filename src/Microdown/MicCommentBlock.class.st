"
A commented line in Pillar is a line that starts with %.
A comment does not run across multiple lines. 
Each commented line should start with %.

I should be a subclass of `MicSingleLineBlock`, not `MicContinuousMarkedBlock`.
"
Class {
	#name : 'MicCommentBlock',
	#superclass : 'MicContinuousMarkedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicCommentBlock >> accept: aVisitor [
 	^ aVisitor visitComment: self
]

{ #category : 'markups' }
MicCommentBlock >> lineMarkup [

	^ CommentedLineMarkup 
]
