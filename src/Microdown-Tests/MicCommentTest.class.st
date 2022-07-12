Class {
	#name : #MicCommentTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicCommentTest >> subjectClass [

	^ MicCommentBlock
]

{ #category : #tests }
MicCommentTest >> testCommentAPI [

	| comment |
	comment := (parser parse: '% **a b**') children first.
	self assert: comment class equals: MicCommentBlock.
	self assert: comment text equals: '**a b**'.

]
