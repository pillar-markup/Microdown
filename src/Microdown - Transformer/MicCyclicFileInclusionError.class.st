Class {
	#name : #MicCyclicFileInclusionError,
	#superclass : #Error,
	#instVars : [
		'files'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #accessing }
MicCyclicFileInclusionError >> files: aCollection [ 
	files := aCollection
]
