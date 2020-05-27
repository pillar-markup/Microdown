"
I'm the delimiter for strikethrough format.
"
Class {
	#name : #GHMStrikeDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMStrikeDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMStrikeDelimiter class >> markup [
	^ '~'
]

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
