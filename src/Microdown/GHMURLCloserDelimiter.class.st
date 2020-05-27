"
I am the closer delimiter for URL.
"
Class {
	#name : #GHMURLCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMURLCloserDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMURLCloserDelimiter class >> markup [
	^ ')'
]

{ #category : #testing }
GHMURLCloserDelimiter >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMURLCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMURLCloserDelimiter >> markup [
	^ ')'
]

{ #category : #accessing }
GHMURLCloserDelimiter >> type [
	^ #url
]
