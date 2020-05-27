"
I am the closer delimiter for raw.
"
Class {
	#name : #GHMRawCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMRawCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMRawCloserDelimiter class >> markup [
	^ '}}'
]

{ #category : #accessing }
GHMRawCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMRawCloserDelimiter >> type [
	^ #raw
]
