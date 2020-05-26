"
I am the delimiter for monospace/inline code format.
"
Class {
	#name : #GHMMonospaceDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMMonospaceDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter >> markup [
	^ '`'
]

{ #category : #accessing }
GHMMonospaceDelimiter >> type [
	^ #monospace
]
