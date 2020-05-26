Class {
	#name : #MicCommentBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#category : #Microdown
}

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
