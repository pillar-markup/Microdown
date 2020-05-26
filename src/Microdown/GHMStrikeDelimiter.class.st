"
I'm the delimiter for strikethrough format.
"
Class {
	#name : #GHMStrikeDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMStrikeDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMStrikeDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMStrikeDelimiter >> markup [
	^ '~'
]

{ #category : #accessing }
GHMStrikeDelimiter >> type [
	^ #strike
]
