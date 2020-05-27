"
I am the opener delimiter for link name.
"
Class {
	#name : #GHMLinkNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMLinkNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter class >> markup [
	^ '['
]

{ #category : #testing }
GHMLinkNameOpenerDelimiter >> isActive [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> markup [
	^ '['
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> type [
	^ #linkName
]
