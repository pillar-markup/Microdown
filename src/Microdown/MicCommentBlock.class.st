Class {
	#name : #MicCommentBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#category : #'Microdown-Model'
}

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
