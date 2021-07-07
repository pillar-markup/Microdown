Class {
	#name : #MicCodeblockEvaluator,
	#superclass : #MicNodeTransformer,
	#category : #'Microdown - Transformer'
}

{ #category : #visiting }
MicCodeblockEvaluator >> visitCode: aCodeBlock [
	aCodeBlock isEvaluated
		ifTrue: [ self replace: aCodeBlock evaluate ]
]
