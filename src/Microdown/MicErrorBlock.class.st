"
I am an error block. If there is a parse error, I am instantiated as a placeholder
"
Class {
	#name : #MicErrorBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'errorMessage'
	],
	#category : #'Microdown-Model'
}

{ #category : #visiting }
MicErrorBlock >> accept: aVisitor [
	aVisitor visitError: self
]

{ #category : #public }
MicErrorBlock >> addLineAndReturnNextNode: line [
	self error: 'The error block do not have syntax, so this should not happen'
]

{ #category : #public }
MicErrorBlock >> canConsumeLine: line [
	self error: 'The error block do not have syntax, so this should not happen'
]
