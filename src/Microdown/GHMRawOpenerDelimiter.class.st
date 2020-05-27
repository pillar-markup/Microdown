"
I am the opener delimiter for raw.
"
Class {
	#name : #GHMRawOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMRawOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMRawOpenerDelimiter class >> markup [
	^ '{{'
]

{ #category : #accessing }
GHMRawOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMRawOpenerDelimiter >> type [
	^ #raw
]
