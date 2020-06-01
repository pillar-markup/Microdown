"
I'm a delimiter for math inline environment.
"
Class {
	#name : #MicMathDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicMathDelimiter class >> associatedInlineBlock [
	^ MicMathInlineBlock 
]

{ #category : #accessing }
MicMathDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicMathDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicMathDelimiter class >> markup [
	^ '$'
]

{ #category : #accessing }
MicMathDelimiter class >> type [
	^ #math
]
