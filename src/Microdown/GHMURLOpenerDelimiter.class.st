"
I'm the opener delimiter for URL.
"
Class {
	#name : #GHMURLOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #testing }
GHMURLOpenerDelimiter >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> markup [
	^ '('
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> type [
	^ #url
]
