"
I am the closer delimiter for link name.
"
Class {
	#name : #MicLinkNameCloserDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicLinkNameCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicLinkNameCloserDelimiter class >> markup [
	^ ']'
]

{ #category : #accessing }
MicLinkNameCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
MicLinkNameCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
MicLinkNameCloserDelimiter >> markup [
	^ ']'
]

{ #category : #accessing }
MicLinkNameCloserDelimiter >> type [
	^ #linkName
]
