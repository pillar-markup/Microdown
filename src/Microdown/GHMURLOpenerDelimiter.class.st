"
I'm the opener delimiter for URL.
"
Class {
	#name : #GHMURLOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMURLOpenerDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter class >> markup [
	^ '('
]

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
