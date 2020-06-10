"
A commented line in Pillar is a line starting with %.
A comment does not flow on multiple lines. 
Each line to be commented should start with %.
"
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
