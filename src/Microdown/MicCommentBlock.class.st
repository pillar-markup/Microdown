Class {
	#name : #MicCommentBlock,
	#superclass : #MicContinuousMarkedBlock,
	#category : #'Microdown-Model'
}

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
