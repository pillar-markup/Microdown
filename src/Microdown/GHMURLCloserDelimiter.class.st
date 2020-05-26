"
I am the closer delimiter for URL.
"
Class {
	#name : #GHMURLCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

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
