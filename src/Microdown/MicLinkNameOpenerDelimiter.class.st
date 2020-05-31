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
MicLinkNameOpenerDelimiter class >> markup [
	^ '['
]

{ #category : #testing }
MicLinkNameOpenerDelimiter >> isActive [
	^ false
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter >> markup [
	self flag: #fixme. "do we need it on instance side?"
	^ self class markup
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter >> type [
	^ #linkName
]
