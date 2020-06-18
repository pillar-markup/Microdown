Class {
	#name : #MicAnnotationInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#instVars : [
		'name',
		'arguments'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicAnnotationInlineBlock >> arguments [
	^ arguments
]

{ #category : #converting }
MicAnnotationInlineBlock >> asPillar [
	| lineStream resultArray micBlock |
	micBlock := MicEnvironmentBlock new.
	lineStream := substring readStream.
	resultArray := micBlock findNameAndArguments: lineStream.
	name := resultArray first.
	arguments := resultArray second.
	^ micBlock asPillarWithTag: name withParameters: arguments 
]

{ #category : #accessing }
MicAnnotationInlineBlock >> name [
	^ name
]
