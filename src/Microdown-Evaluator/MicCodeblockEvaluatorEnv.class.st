"
I'm stupid helper to support the evaluation of codeBlock.

When the MicCodeBlockEvaluator is loaded and the eval parameter is true then 
the user can use the stream to generate a different body of the codeblock using stream as receiver of
stream messages.
"
Class {
	#name : #MicCodeblockEvaluatorEnv,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-Evaluator'
}

{ #category : #initialization }
MicCodeblockEvaluatorEnv >> setStream: aStream [
	stream := aStream
]
