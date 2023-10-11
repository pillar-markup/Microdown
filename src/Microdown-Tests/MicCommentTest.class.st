Class {
	#name : 'MicCommentTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicCommentTest >> subjectClass [

	^ MicCommentBlock
]

{ #category : 'tests' }
MicCommentTest >> testCommentAPI [

	| comment |
	comment := (parser parse: '% **a b**') children first.
	self assert: comment class equals: MicCommentBlock.
	self assert: comment text equals: '**a b**'.

]
