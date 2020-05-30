"
I am the opener delimiter for raw.
"
Class {
	#name : #MicRawOpenerDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicRawOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicRawOpenerDelimiter class >> markup [
	^ '{{'
]

{ #category : #accessing }
MicRawOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicRawOpenerDelimiter >> type [
	^ #raw
]
