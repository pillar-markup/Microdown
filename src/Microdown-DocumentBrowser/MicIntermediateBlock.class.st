"
I am a block that is used to group other nodes internally in a microdown trees
"
Class {
	#name : #MicIntermediateBlock,
	#superclass : #MicAbstractBlock,
	#category : #'Microdown-DocumentBrowser-Manifest'
}

{ #category : #visiting }
MicIntermediateBlock >> accept: aVisitor [
	self children do: [ :n | n accept: aVisitor ]
]

{ #category : #public }
MicIntermediateBlock >> addLineAndReturnNextNode: line [
	"I am not supposed to be generated during parsing, and this method should not be called on me"
	self shouldNotImplement
]

{ #category : #public }
MicIntermediateBlock >> canConsumeLine: line [
	"I am not supposed to be generated during parsing, and this method should not be called on me"
	self shouldNotImplement
]
