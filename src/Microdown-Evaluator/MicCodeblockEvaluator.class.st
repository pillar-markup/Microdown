"
This transformer compile the code content by a codeblock which have the parameters eval at true.


"
Class {
	#name : #MicCodeblockEvaluator,
	#superclass : #MicNodeTransformer,
	#category : #'Microdown-Evaluator'
}

{ #category : #visiting }
MicCodeblockEvaluator >> visitCode: aCodeBlock [
	aCodeBlock isEvaluated
		ifTrue: [ self replace: aCodeBlock evaluate ]
]
