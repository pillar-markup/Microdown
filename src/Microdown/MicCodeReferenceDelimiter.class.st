Class {
	#name : #MicCodeReferenceDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicCodeReferenceDelimiter class >> associatedInlineBlock [
	^ MicCodeReferenceInlineBlock
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> markup [
	^ '@'
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> type [
	^ #codeReference
]
