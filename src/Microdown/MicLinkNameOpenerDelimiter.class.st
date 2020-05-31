"
I am the opener delimiter for link name.
"
Class {
	#name : #MicLinkNameOpenerDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> markup [
	^ '['
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> type [
	^ #linkName
]
