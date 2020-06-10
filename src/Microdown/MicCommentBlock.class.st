Class {
	#name : #MicCommentBlock,
	#superclass : #MicContinuousMarkedBlock,
	#category : #'Microdown-Model'
}

{ #category : #markups }
MicCommentBlock >> asPillar [ 
		
	^ PRCommentedLine new
			text: text ;
			yourself
			
]

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
