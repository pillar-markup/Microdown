"
I am the delimiter for monospace/inline code format.
"
Class {
	#name : #MicMonospaceDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicMonospaceDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicMonospaceDelimiter class >> markup [
	^ '`'
]

{ #category : #accessing }
MicMonospaceDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
MicMonospaceDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicMonospaceDelimiter >> markup [
	^ '`'
]

{ #category : #accessing }
MicMonospaceDelimiter >> type [
	^ #monospace
]
