"
I am the closer delimiter for raw.
"
Class {
	#name : #MicRawCloserDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicRawCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicRawCloserDelimiter class >> markup [
	^ '}}'
]

{ #category : #accessing }
MicRawCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
MicRawCloserDelimiter >> type [
	^ #raw
]
