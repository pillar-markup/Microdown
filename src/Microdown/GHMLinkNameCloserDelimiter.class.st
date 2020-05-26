"
I am the closer delimiter for link name.
"
Class {
	#name : #GHMLinkNameCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> markup [
	^ ']'
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> type [
	^ #linkName
]
