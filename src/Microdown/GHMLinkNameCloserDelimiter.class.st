"
I am the closer delimiter for link name.
"
Class {
	#name : #GHMLinkNameCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMLinkNameCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter class >> markup [
	^ ']'
]

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
