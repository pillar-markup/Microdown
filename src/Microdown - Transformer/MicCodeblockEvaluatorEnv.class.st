Class {
	#name : #MicCodeblockEvaluatorEnv,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #initialization }
MicCodeblockEvaluatorEnv >> setStream: aStream [
	stream := aStream
]
